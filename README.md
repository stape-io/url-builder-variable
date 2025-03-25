# URL Builder Variable for Google Tag Manager Server Container

The **URL Builder Variable** for Google Tag Manager Server Container allows you to dynamically build URLs by adding query parameters to a provided base URL. This variable is especially useful for creating custom URLs that require additional data, such as campaign tracking parameters or other query strings, without manual URL construction.

### Features

- Parse a base URL and append query parameters.
- Modify existing query parameters or add new ones.
- Handle URL encoding automatically.
- Supports both single and repeated query parameters.

## Getting Started

1. Add the **URL Builder Variable** to your GTM Server container.
2. Provide the **base URL** (e.g., `https://example.com/path/`).
3. Define the **query parameters** you want to add, including their keys and values.
4. The URL Builder will process and generate a complete URL with all parameters, handling encoding and repeated parameters.

## Open Source

The **URL Builder Variable** for GTM Server is developed and maintained by the [Stape Team](https://stape.io/) under the Apache 2.0 license.