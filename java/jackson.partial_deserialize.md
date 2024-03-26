# Overview

1. How to partially deserialize JSON with [Jackson](https://github.com/FasterXML/jackson)
    - eg. To retain some raw nested JSON

# Step-1: Make a class to hold indexes of the original JSON

```java
@Value
public class RawJSONIndexes {

    /** Inclusive */
    int start;

    /** exclusive */
    int end;
    
    @lombok.Builder(builderClassName = "Builder")
    private RawJSONIndexes(int start, int end) {
        checkArgument(start >= 0, "start must be non-negative");
        checkArgument(end > start, "end must be greater than start");

        this.end = end;
        this.start = start;
    }
}
```

# Step-2: Make a custom [Deserializer](https://javadoc.io/doc/com.fasterxml.jackson.core/jackson-databind/2.14.2/com/fasterxml/jackson/databind/JsonDeserializer.html)

```java
public final class RawJSONDeserializer extends JsonDeserializer<RawJSONIndexes> {

    @Override
    @SneakyThrows
    public RawJSONIndexes deserialize(JsonParser p, DeserializationContext ctxt) {

        final int start = (int) p.getTokenLocation().getCharOffset();
        
        // NOTE: we only care where this objects starts and ends
        // NOTE: this line handles nested objects & arrays too        
        p.skipChildren();
        
        final int end = (int) p.getCurrentLocation().getCharOffset();

        return RawJSONIndexes.builder()
            .start(start)
            .end(end)
            .build();
    }
}
```

# Step-3: Register your custom [Deserializer](https://javadoc.io/doc/com.fasterxml.jackson.core/jackson-databind/2.14.2/com/fasterxml/jackson/databind/JsonDeserializer.html)

```java
    ObjectMapper mapperForRawJSON = ... // get from Dependency Injection or clone another ObjectMapper

    final var module = new SimpleModule()
        .addDeserializer(
            RawJSONIndexes.class,
            new RawJSONDeserializer());

    mapperForRawJSON.registerModule(module);
```

# Step-4: Make some dummy JSON to test

```java
    // Add extra spaces, line breaks, inconsistent spacing, ... to prove the output wasn't auto-cleaned
    // NOTE: Nested objects and arrays also work
     
    final var exampleJSON = """
        {
            "fooBars": [
                { "b": true,   "n": 6, "s": "quuz",   "myObj":{"a":    3}  },
                { "b": false, "n": 103, "s":  "yarp"  , "myArr": ["t"] }
            ]
        }
        """.trim();           
```

# Step-5: Parse & Use the partially deserialized JSON

```java
    Map<String, List<RawJSONIndexes>> parsed =
        mapperForRawJSON.readValue(
            exampleJSON,
            new TypeReference<>() {});

    parsed.get("fooBars") // 'fooBars' matches the outermost property 
        .forEach(range -> {
            var currentRawJSON = exampleJSON.substring(
                range.getStart(), 
                range.getEnd());

            System.out.println("currentRawJSON: " + currentRawJSON); // or persist or whatever
        });
```

# Other Resources

1. https://www.javadoc.io/doc/com.fasterxml.jackson.core/jackson-core/2.14.2/com/fasterxml/jackson/core/JsonParser.html
1. https://javadoc.io/doc/com.fasterxml.jackson.core/jackson-databind/2.14.2/com/fasterxml/jackson/databind/JsonDeserializer.html
1. https://docs.oracle.com/en/java/javase/14/docs/specs/text-blocks-jls.html
