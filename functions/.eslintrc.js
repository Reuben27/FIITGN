module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    "eslint:recommended",
    "google",
  ],
  rules: {
    "quotes": ["error", "double", {"avoidEscape": true}],
    "linebreak-style": 0,
    "indent": "off",
    "eol-last": 0,
    "jsx-quotes": [2, "prefer-single"],
  },
};
