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
