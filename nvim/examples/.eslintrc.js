module.exports = {
  parser: "@babel/eslint-parser",

  root: true,

  env: {
    browser: true,
    jasmine: true,
    es2020: true,
    jest: true
  },

  extends: [
    "standard",
    "plugin:vue/vue3-essential",
  ],

  plugins: [
    "jest",
    "simple-import-sort"
  ],

  parserOptions: {
    ecmaVersion: "2020",
    ecmaFeatures: {
      jsx: true
    },
    sourceType: "module",
    requireConfigFile: false
  },

  rules: {
    "brace-style": ["error", "stroustrup"],
    "class-methods-use-this": "off",
    "comma-dangle": ["error", "always-multiline"],
    "import/no-extraneous-dependencies": "off",
    "import/prefer-default-export": "off",
    "indent": ["error", 2],
    "jest/no-disabled-tests": "warn",
    "jest/no-focused-tests": "error",
    "jest/no-identical-title": "warn",
    "linebreak-style": ["error", "unix"],
    "padding-line-between-statements": [
      "warn",
      { "blankLine": "always", "prev": ["const", "let", "var"], "next": "*" },
      { "blankLine": "any", "prev": ["const", "let", "var"], "next": ["const", "let", "var"] }
    ],
    "no-console": ["warn"],
    "no-underscore-dangle": "off",
    "quotes": ["error", "single"],
    "object-shorthand": ["error", "always", {
      "avoidQuotes": false
    }],
    "semi": ["error", "never"],
    "simple-import-sort/imports": "error",
    "sort-imports": ["error", {
      "ignoreCase": true,
      "ignoreDeclarationSort": true
    }],
    "space-before-function-paren": ["warn", {
      "anonymous": "never",
      "named": "never",
      "asyncArrow": "always"
    }]
  }
}
