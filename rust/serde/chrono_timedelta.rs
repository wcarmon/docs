pub mod timedelta_milliseconds {
    use chrono::TimeDelta;
    use serde::{Deserialize, Deserializer, Serializer};

    pub fn serialize<S>(duration: &TimeDelta, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: Serializer,
    {
        serializer.serialize_i64(duration.num_milliseconds())
    }

    pub fn deserialize<'de, D>(deserializer: D) -> Result<TimeDelta, D::Error>
    where
        D: Deserializer<'de>,
    {
        Ok(TimeDelta::milliseconds(i64::deserialize(deserializer)?))
    }
}

pub mod timedelta_milliseconds_opt {
    use chrono::TimeDelta;
    use serde::{de, Deserialize, Deserializer, Serializer};

    pub fn serialize<S>(opt: &Option<TimeDelta>, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: Serializer,
    {
        match *opt {
            None => serializer.serialize_none(),
            Some(dur) => serializer.serialize_some(&dur.num_milliseconds()),
        }
    }

    pub fn deserialize<'de, D>(deserializer: D) -> Result<Option<TimeDelta>, D::Error>
    where
        D: Deserializer<'de>,
    {
        deserializer.deserialize_option(OptionMillisecondTimeDeltaVisitor)
    }

    struct OptionMillisecondTimeDeltaVisitor;

    impl<'de> de::Visitor<'de> for OptionMillisecondTimeDeltaVisitor {
        type Value = Option<TimeDelta>;

        fn expecting(&self, formatter: &mut core::fmt::Formatter) -> core::fmt::Result {
            formatter.write_str("Some(milliseconds) or None")
        }

        fn visit_none<E>(self) -> Result<Self::Value, E>
        where
            E: de::Error,
        {
            Ok(None)
        }

        fn visit_some<D>(self, d: D) -> Result<Self::Value, D::Error>
        where
            D: de::Deserializer<'de>,
        {
            let millis = i64::deserialize(d)?;
            Ok(Some(TimeDelta::milliseconds(millis)))
        }

        fn visit_unit<E>(self) -> Result<Self::Value, E>
        where
            E: de::Error,
        {
            Ok(None)
        }
    }
}
