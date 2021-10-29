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

let urlParams = '';
let url = data.url;

for (let key in data.url_data) {
  if (urlParams) {
    urlParams = urlParams + '&' + enc(data.url_data[key].key) + '=' + enc(data.url_data[key].value);
  } else {
    urlParams = enc(data.url_data[key].key) + '=' + enc(data.url_data[key].value);
  }
}

if (urlParams) {
  url = url + '?' + urlParams;
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


