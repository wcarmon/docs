# Overview
1. How to add a custom Serializer & Deserializer for a record
1. No annotation magic, full access to the JVM


```java
@JsonSerialize(using = Foo.Serializer.class)
@Builder(toBuilder = true)
public record Foo(
        String uuid,
        String name,
        String email,
        Instant ts) {

        Foo {
            // ... set defaults here ...

            // ... validation here ...
        }

    /** Custom deserializer */
    @JsonCreator
    public static Foo fromRawProperties(Map<String, Object> props) {
        requireNonNull(props, "props is required and null.");

        // ... read the map here

        return Foo.builder()
            // ... set fields here
            .build();
    }

    /** Custom serializer */
    static class Serializer extends JsonSerializer<Foo> {

        @Override
        @SneakyThrows
        public void serialize(
                Foo entity,
                JsonGenerator jGen,
                SerializerProvider _unused) {

            requireNonNull(entity, "entity is required and null.");

            jGen.writeStartObject();

            jGen.writeNumberField("tsEpochMillis", entity.ts.toEpochMilli());
            jGen.writeStringField("name", entity.name);
            jGen.writeStringField("email", entity.email);
            jGen.writeStringField("uuid", entity.uuid);

            // -- Extra/synthetic field only for Serializer
            // -- Useful in places like WebSockets where messages include type info
            jGen.writeStringField("type", entity.getClass().getSimpleName());

            jGen.writeEndObject();
        }
    }
}
```


# Other resources
1. https://fasterxml.github.io/jackson-databind/javadoc/2.14/com/fasterxml/jackson/databind/JsonSerializer.html

