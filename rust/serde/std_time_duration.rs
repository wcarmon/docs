// NOTE: requires #![feature(duration_constructors)]
pub mod std_duration_millis {
    use serde::de::Error;
    use serde::{Deserialize, Deserializer, Serializer};

    pub fn serialize<S>(duration: &std::time::Duration, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: Serializer,
    {
        // -- GOTCHA: lose precision since parser only handles u64
        serializer.serialize_u64(duration.as_millis() as u64)
    }

    pub fn deserialize<'de, D>(deserializer: D) -> Result<std::time::Duration, D::Error>
    where
        D: Deserializer<'de>,
    {
        let pos_millis = u64::deserialize(deserializer).map_err(|e| {
            D::Error::custom(format!("failed to deserialize: millis to u64: {}", e))
        })?;

        Ok(std::time::Duration::from_millis(pos_millis))
    }
}
