# Overview
1. How to add a custom Serializer for a record


```java
@JsonSerialize(using = Foo.Serializer.class)
@Builder(toBuilder = true)
public record Foo(
        String uuid,
        String name,
        String email,
        Instant ts) {

        Foo {
            // ... validation
        }

    // -- Custom serializer
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
            jGen.writeStringField("type", entity.getClass().getSimpleName());

            jGen.writeEndObject();
        }
    }
}
```


# Other resources
1. https://fasterxml.github.io/jackson-databind/javadoc/2.14/com/fasterxml/jackson/databind/JsonSerializer.html

