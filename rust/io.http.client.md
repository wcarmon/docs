# Overview
1. Helpful snippets for using [reqwest](https://docs.rs/reqwest/latest/reqwest/)


# Parse response body
```rs
    ...

    let resp = reqwest::get(&url)
        .await
        .context(
            format!("failed to make http request: url={url}\n"))?;

    ensure!(resp.status().is_success(),
        "unexpected HTTP StatusCode: {}", resp.status());

    let resp_body = resp.text().await
        .context("failed to read response body\n")?;

    let resp = serde_json::from_str::<Vec<MyRowOfData>>(&resp_body)
        .with_context(|| {
            let mut short_body = resp_body;
            short_body.truncate(512);
            format!("failed to deserialize returned data:\n{short_body}\n")
        })?;
```

# Other Resources
1. TODO