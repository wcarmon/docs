# Overview
1. How to partially deserialize JSON with [Jackson](https://github.com/FasterXML/jackson) 
    (eg. to retain some raw nested JSON)


# Step-1: Make a class for holding indexes on the original JSON 
```java
@Value
public class RawJSONIndexes {

    /** Inclusive */
    int startIndex;

    /** exclusive */
    int endIndex;
    
    @lombok.Builder(
        builderClassName = "Builder",
        toBuilder = true)
    private RawJSONIndexes(
        int startIndex,
        int endIndex
    ) {
        checkArgument(startIndex >= 0, "startIndex must be non-negative");
        checkArgument(endIndex > startIndex, "endIndex must be greater than startIndex");

        this.endIndex = endIndex;
        this.startIndex = startIndex;
    }
}
```


# Step-2: Make a custom deserializer
```java
class RawJSONDeserializer extends JsonDeserializer<RawJSONIndexes> {

    @Override
    @SneakyThrows
    public RawJSONIndexes deserialize(JsonParser p, DeserializationContext ctxt) {

        final int startOffset = (int) p.getTokenLocation().getCharOffset();
        
        p.skipChildren();  // NOTE: this handles nested objects & arrays
        
        final int endOffset = (int) p.getCurrentLocation().getCharOffset();

        return RawJSONIndexes.builder()
            .startIndex(startOffset)
            .endIndex(endOffset)
            .build();
    }
}
```


# Step-3: Register your custom deserializer
```java
    ObjectMapper mapperForRawJSON = ... // get from DI

    final var module = new SimpleModule()
        .addDeserializer(
            RawJSONIndexes.class,
            new RawJSONDeserializer());

    mapperForRawJSON.registerModule(module);
```


# Step-4: Make some dummy json to test
```java

    // Add extra spaces & inconsistent spacing to prove the output wasn't cleaned 
    // NOTE: Nested objects and arrays also work
     
    var exampleJSON = """
        {
            "fooBars": [
                { "b": true,   "n": 6, "s": "quuz",   "o":{"a":    3}  },
                { "b": false, "n": 103, "s":  "yarp"  , "arr": ["t"] }
            ]
        }
        """.trim();           
```

# Step-5: Parse & Use 
```java
    Map<String, List<RawJSONIndexes>> parsed =
        mapperForRawJSON.readValue(
            exampleJSON,
            new TypeReference<>() {});

    parsed.get("fooBars")
        .forEach(indexPair -> {
            var currentRawJSON = exampleJSON.substring(
                indexPair.getStartIndex(), 
                indexPair.getEndIndex());

            System.out.println("currentRawJSON: " + currentRawJSON); // or persist or whatever
        });
```


# Other resources
1. https://www.javadoc.io/doc/com.fasterxml.jackson.core/jackson-core/2.14.2/com/fasterxml/jackson/core/JsonParser.html
1. https://javadoc.io/doc/com.fasterxml.jackson.core/jackson-databind/2.14.2/com/fasterxml/jackson/databind/JsonDeserializer.html
