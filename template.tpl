___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "URL Builder",
  "description": "Provides an interface for building URLs.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "url",
    "displayName": "URL",
    "simpleValueType": true,
    "valueHint": "https://",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "REGEX",
        "args": [
          "^https://.*"
        ]
      }
    ]
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "url_data",
    "simpleTableColumns": [
      {
        "defaultValue": "",
        "displayName": "Key",
        "name": "key",
        "type": "TEXT"
      },
      {
        "defaultValue": "",
        "displayName": "Value",
        "name": "value",
        "type": "TEXT"
      }
    ],
    "displayName": "Query parameters"
  }
]


___SANDBOXED_JS_FOR_SERVER___

const encodeUriComponent = require('encodeUriComponent');

let url = data.url;
// Parse the URL to check for existing query parameters
let urlParts = url.split('?');
let baseUrl = urlParts[0];
let existingParams = {};

// Parse existing query parameters if any
if (urlParts.length > 1) {
  let paramPairs = urlParts[1].split('&');
  for (let i = 0; i < paramPairs.length; i++) {
    let pair = paramPairs[i].split('=');
    if (pair.length === 2) {
      existingParams[pair[0]] = pair[1];
    }
  }
}

// Process new parameters, updating existing ones if needed
for (let key in data.url_data) {
  existingParams[enc(data.url_data[key].key)] = enc(data.url_data[key].value);
}

// Build the final URL with all parameters
let finalParams = '';
for (let key in existingParams) {
  if (finalParams) {
    finalParams = finalParams + '&' + key + '=' + existingParams[key];
  } else {
    finalParams = key + '=' + existingParams[key];
  }
}

// Construct the final URL
if (finalParams) {
  url = baseUrl + '?' + finalParams;
}

return url;
  
function enc(data) {
  data = data || '';
  return encodeUriComponent(data);
}


___TESTS___

scenarios: []


___NOTES___

Created on 30/09/2021, 18:10:20


