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

const parseUrl = require('parseUrl');
const makeTableMap = require('makeTableMap');
const encodeUriComponent = require('encodeUriComponent');
const decodeUriComponent = require('decodeUriComponent');
const getType = require('getType');

// Parse the URL to check for existing query parameters
const parsedUrl = parseUrl(data.url);
const baseUrl = parsedUrl.origin + parsedUrl.pathname;
const hash = parsedUrl.hash;
// Parse existing query parameters if any
const searchParams = parsedUrl.searchParams; // Uses decoded keys and values.

// Process new parameters, updating existing ones if needed
const newParams = makeTableMap(data.url_data || [], 'key', 'value');
for (const key in newParams) {
  const newKey = decodeUriComponent(key); // If the person added it either decoded or encoded in the UI.
  const newValue = newParams[key];
  searchParams[newKey] = newValue; // newKey and newValue don't need to be encoded now. They will be encoded later.
}

const finalParams = [];
for (const key in searchParams) {
  const value = searchParams[key];
  getType(value) === 'array' // For parameters that are repeated.
    ? value.forEach((v) => finalParams.push(enc(key) + '=' + enc(v)))
    : finalParams.push(enc(key) + '=' + enc(value));
}

// Build the final URL with all parameters
return baseUrl + (finalParams.length ? '?' + finalParams.join('&') : '') + hash;

function enc(data) {
  data = data || '';
  return encodeUriComponent(data);
}


___TESTS___

scenarios:
- name: URL without parameters
  code: |-
    const expectedValue = 'https://example.com/path/?this=that&foo=bar#hash';
    const mockData = {
      url: page_location_without_query_params,
      url_data: [
        { key: 'this', value: 'that' },
        { key: 'foo', value: 'bar' },
      ]
    };

    const variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo(expectedValue);
- name: URL with parameters
  code: |-
    const expectedValue = 'https://example.com/path/?oneparam=1%202%203%204&teste=123&anotherparam=hahsdhasd&anotherparam=duplicated&par%C3%A2metro=test%C3%A3o&t%C3%A9%C3%A7=foobar&this=that&foo=bar#hash';
    const mockData = {
      url: page_location_with_query_params,
      url_data: [
        { key: 'this', value: 'that' },
        { key: 'foo', value: 'bar' },
        { key: 'par%C3%A2metro', value: 'testão' },
        { key: 'téç', value: 'foobar' }
      ]
    };

    const variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo(expectedValue);
setup: |-
  const page_location_without_query_params = 'https://example.com/path/#hash';
  const page_location_with_query_params = 'https://example.com/path/?oneparam=1%202%203%204&teste=123&anotherparam=hahsdhasd&par%C3%A2metro=%C3%A7%C3%A3o%3F1J23I12I3J&anotherparam=duplicated&t%C3%A9%C3%A7=foobar#hash';


___NOTES___

Created on 30/09/2021, 18:10:20


