pub mod std_system_time_epoch_millis {
    use serde::ser::Error;
    use serde::{Deserialize, Deserializer, Serializer};
    use std::time::{SystemTime, UNIX_EPOCH};

    pub fn serialize<S>(ts: &SystemTime, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: Serializer,
    {
        let epoch_millis = if ts >= &UNIX_EPOCH {
            ts.duration_since(UNIX_EPOCH)
                .map_err(|e| {
                    S::Error::custom(format!(
                        "failed to serialize post-epoch std::time::SystemTime: {}",
                        e
                    ))
                })?
                .as_millis() as i64
        } else {
            // -- GOTCHA: duration_since only works for post-epoch times, so we must flip
            -1 * UNIX_EPOCH
                .duration_since(*ts)
                .map_err(|e| {
                    S::Error::custom(format!(
                        "failed to serialize pre-epoch std::time::SystemTime: {}",
                        e
                    ))
                })?
                .as_millis() as i64
        };

        // -- GOTCHA: lose precision since parser only handles u64
        serializer.serialize_i64(epoch_millis)
    }

    pub fn deserialize<'de, D>(deserializer: D) -> Result<SystemTime, D::Error>
    where
        D: Deserializer<'de>,
    {
        let epoch_millis = i64::deserialize(deserializer)?;

        // -- std doesn't support negative durations
        let delta = std::time::Duration::from_millis(epoch_millis.abs() as u64);
        let out = if epoch_millis >= 0 {
            UNIX_EPOCH + delta
        } else {
            UNIX_EPOCH - delta
        };

        Ok(out)
    }
}
