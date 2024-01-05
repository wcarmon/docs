// See http://json.schemastore.org/eslintrc
module.exports = {
  "env": {
    "browser": true,
    "es2021": true,
    "node": false
  },
  "extends": [
    "eslint:all",
    "plugin:@angular-eslint/all",
    "plugin:@angular-eslint/template/process-inline-templates",
    "plugin:@typescript-eslint/all",
    "plugin:@typescript-eslint/recommended-requiring-type-checking",
    "plugin:import/errors",
    "plugin:import/warnings",
    "plugin:node/recommended",
    "plugin:react/recommended",
    "plugin:security/recommended",
    "plugin:sonarjs/recommended",
    "standard-with-typescript"
  ],
  "overrides": [
    {
      "extends": [
        "plugin:@angular-eslint/template/recommended"
      ],
      "files": [
        "*.html"
      ],
      "rules": {}
    }
  ],
  "ignorePatterns": [
    "projects/**/*"
  ],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "ecmaFeatures": {
      "jsx": true
    },
    "ecmaVersion": 11,
    "project": "./tsconfig.json",
    "sourceType": "module"
  },
  "plugins": [
    "@typescript-eslint",
    "filenames",
    "jsdoc",
    "promise",
    "react",
    "security",
    "sonarjs",
    "unicorn",
  ],
  "rules": {
    "@angular-eslint/component-selector": [
      "error",
      {
        "prefix": "app",
        "style": "kebab-case",
        "type": "element"
      }
    ],
    "@angular-eslint/directive-selector": [
      "error",
      {
        "prefix": "app",
        "style": "camelCase",
        "type": "attribute"
      }
    ],
    "@angular-eslint/prefer-on-push-component-change-detection": "warn",
    "@angular-eslint/sort-ngmodule-metadata-arrays": "error",
    "@typescript-eslint/array-type": ["error", {default: "array-simple"}],
    "@typescript-eslint/ban-ts-comment": "warn",
    "@typescript-eslint/comma-dangle": "off",
    "@typescript-eslint/consistent-type-assertions": [
      "warn",
      {assertionStyle: "angle-bracket"},
    ],
    "@typescript-eslint/consistent-type-imports": "off",
    "@typescript-eslint/explicit-function-return-type": "warn",
    "@typescript-eslint/explicit-member-accessibility": "off",
    "@typescript-eslint/explicit-module-boundary-types": "error",
    "@typescript-eslint/indent": "off",
    "@typescript-eslint/naming-convention": "warn",
    "@typescript-eslint/no-empty-function": "warn",
    "@typescript-eslint/no-empty-interface": "warn",
    "@typescript-eslint/no-extra-parens": "off", // conflicts with prettier
    "@typescript-eslint/no-extraneous-class": "warn",
    "@typescript-eslint/no-inferrable-types": "warn",
    "@typescript-eslint/no-magic-numbers": "off",
    "@typescript-eslint/no-non-null-asserted-optional-chain": "warn",
    "@typescript-eslint/no-non-null-assertion": "warn",
    "@typescript-eslint/no-useless-constructor": "warn",
    "@typescript-eslint/no-parameter-properties": [
      "warn",
      {allows: ["private readonly"]},
    ],
    "@typescript-eslint/no-require-imports": "off", // incompatible with auto-bind
    "@typescript-eslint/no-type-alias": "warn",
    "@typescript-eslint/no-unnecessary-condition": "warn",
    "@typescript-eslint/no-unsafe-assignment": "warn",
    "@typescript-eslint/no-unsafe-call": "warn", // annoying for error properties
    "@typescript-eslint/no-unsafe-member-access": "warn", // annoying for express.js code
    "@typescript-eslint/no-unsafe-return": "warn",
    "@typescript-eslint/no-unused-vars": "warn",
    "@typescript-eslint/no-unused-vars-experimental": "off",
    "@typescript-eslint/no-use-before-define": "off",
    "@typescript-eslint/no-var-requires": "warn",
    "@typescript-eslint/object-curly-spacing": "off", // let prettier manage
    "@typescript-eslint/prefer-readonly-parameter-types": "off",
    "@typescript-eslint/promise-function-async": "warn",
    "@typescript-eslint/quotes": "warn",
    "@typescript-eslint/require-await": "warn",
    "@typescript-eslint/restrict-template-expressions": "warn",
    "@typescript-eslint/semi": "off", // redundant
    "@typescript-eslint/space-before-function-paren": "off",
    "@typescript-eslint/strict-boolean-expressions": "off",
    "@typescript-eslint/typedef": "warn",
    "@typescript-eslint/unbound-method": "warn", // should allow from ctor, false positives, see auto-bind
    "array-bracket-newline": "off",
    "array-bracket-spacing": "off",
    "array-element-newline": "off",
    "arrow-parens": "off",
    "arrow-spacing": "off",
    "block-spacing": "off",
    "brace-style": "off",
    "capitalized-comments": "off",
    "class-methods-use-this": "warn",
    "comma-dangle": "off",
    "comma-spacing": "off",
    "comma-style": "off",
    "computed-property-spacing": "off",
    "consistent-return": "off", // conflicts with prettier
    "curly": "off",
    "dot-location": "off",
    "dot-notation": "warn",
    "eol-last": "off",
    "filenames/match-exported": "warn",
    "filenames/match-regex": ["error", "^[a-z0-9.-]+$", true],
    "filenames/no-index": "warn",
    "func-call-spacing": "off",
    "func-style": ["error", "declaration", {allowArrowFunctions: true}],
    "function-call-argument-newline": "off",
    "function-paren-newline": "off",
    "generator-star": "off",
    "generator-star-spacing": "off",
    "id-length": ["warn", {exceptions: ["x", "i", "j"]}],
    "implicit-arrow-linebreak": "off",
    "import/no-unresolved": ["warn", {commonjs: true, amd: true}],
    "indent": "off",
    "init-declarations": "warn",
    "jsdoc/check-alignment": "warn",
    "jsdoc/check-examples": "warn",
    "jsdoc/check-indentation": "warn",
    "jsdoc/check-param-names": "warn",
    "jsdoc/check-syntax": "warn",
    "jsdoc/check-tag-names": "warn",
    "jsdoc/check-types": "warn",
    "jsdoc/implements-on-classes": "warn",
    "jsdoc/match-description": "off",
    "jsdoc/newline-after-description": "warn",
    "jsdoc/no-types": "warn",
    "jsdoc/no-undefined-types": "warn",
    "jsdoc/require-description": "off",
    "jsdoc/require-description-complete-sentence": "off",
    "jsdoc/require-example": "off",
    "jsdoc/require-hyphen-before-param-description": "warn",
    "jsdoc/require-jsdoc": "off",
    "jsdoc/require-param": "warn",
    "jsdoc/require-param-description": "off",
    "jsdoc/require-param-name": "warn",
    "jsdoc/require-param-type": "off",
    "jsdoc/require-returns": "warn",
    "jsdoc/require-returns-check": "warn",
    "jsdoc/require-returns-description": "warn",
    "jsdoc/require-returns-type": "off",
    "jsdoc/valid-types": "warn",
    "jsx-quotes": "off",
    "key-spacing": "off",
    "keyword-spacing": "off",
    "line-comment-position": "warn",
    "linebreak-style": "off",
    "lines-around-comment": "off", // conflicts with prettier
    "lines-between-class-members": "off",
    "max-classes-per-file": "warn",
    "max-len": "warn",
    "max-len": ["warn", { code: 110 }],
    "max-lines-per-function": ["warn", { max: 100 }],
    "max-params": ["warn", 4],
    "max-statements": ["warn", 30, {ignoreTopLevelFunctions: true}],
    "multiline-comment-style": "off",
    "multiline-ternary": "off",
    "new-cap": "warn",
    "new-parens": "off",
    "newline-per-chained-call": "off",
    "no-arrow-condition": "off",
    "no-await-in-loop": "warn",
    "no-bitwise": "warn",
    "no-comma-dangle": "off",
    "no-console": "warn",
    "no-continue": "off",
    "no-debugger": "warn",
    "no-extra-parens": "off",
    "no-extra-semi": "off",
    "no-floating-decimal": "off",
    "no-inline-comments": "warn",
    "no-magic-numbers": "off",
    "no-mixed-spaces-and-tabs": "off",
    "no-multi-spaces": "off",
    "no-multiple-empty-lines": "off",
    "no-nested-ternary": "warn",
    "no-plusplus": "off",
    "no-process-env": "off", // valid for nodejs
    "no-reserved-keys": "off",
    "no-shadow": "off", // buggy
    "no-space-before-semi": "off",
    "no-ternary": "off",
    "no-throw-literal": "off", // won't let me throw new instance of interface
    "no-trailing-spaces": "off",
    "no-unused-vars": "off", // TODO: too many false positives on fn signatures
    "no-useless-concat": "warn",
    "no-use-before-define": [
      "warn",
      {classes: true, functions: false, variables: true},
    ],
    "no-useless-constructor": "warn",
    "no-warning-comments": "warn",
    "no-whitespace-before-property": "off",
    "no-wrap-func": "off",
    "node/no-extraneous-import": "warn",
    "node/no-missing-import": "off",
    "node/no-unpublished-import": "off",
    "node/no-unsupported-features/es-syntax": "off",
    "object-curly-spacing": "off",
    "object-property-newline": "warn",
    "object-shorthand": "warn",
    "one-var": ["error", "never"],
    "padded-blocks": "off",
    "prefer-destructuring": "warn",
    "prefer-named-capture-group": "off",
    "promise/always-return": "error",
    "promise/avoid-new": "warn",
    "promise/catch-or-return": "error",
    "promise/no-callback-in-promise": "warn",
    "promise/no-native": "off",
    "promise/no-nesting": "warn",
    "promise/no-new-statics": "error",
    "promise/no-promise-in-callback": "warn",
    "promise/no-return-in-finally": "warn",
    "promise/no-return-wrap": "error",
    "promise/param-names": "error",
    "promise/valid-params": "warn",
    "quote-props": "off", // let prettier manage
    "quotes": [
      "warn",
      "double",
      {avoidEscape: true, allowTemplateLiterals: false},
    ],
    "require-await": "warn",
    "security/detect-child-process": "off",
    "semi": "off",  // let prettier manage
    "semi-spacing": "off",
    "semi-style": "off",
    "sonarjs/cognitive-complexity": "error",
    "sonarjs/max-switch-cases": "error",
    "sonarjs/no-all-duplicated-branches": "error",
    "sonarjs/no-collapsible-if": "error",
    "sonarjs/no-collection-size-mischeck": "error",
    "sonarjs/no-duplicate-string": "error",
    "sonarjs/no-duplicated-branches": "error",
    "sonarjs/no-element-overwrite": "error",
    "sonarjs/no-extra-arguments": "error",
    "sonarjs/no-identical-conditions": "error",
    "sonarjs/no-identical-expressions": "error",
    "sonarjs/no-identical-functions": "error",
    "sonarjs/no-inverted-boolean-check": "error",
    "sonarjs/no-one-iteration-loop": "error",
    "sonarjs/no-redundant-boolean": "error",
    "sonarjs/no-redundant-jump": "error",
    "sonarjs/no-same-line-conditional": "error",
    "sonarjs/no-small-switch": "error",
    "sonarjs/no-unused-collection": "error",
    "sonarjs/no-use-of-empty-return-value": "error",
    "sonarjs/no-useless-catch": "error",
    "sonarjs/prefer-immediate-return": "error",
    "sonarjs/prefer-object-literal": "error",
    "sonarjs/prefer-single-boolean-return": "error",
    "sonarjs/prefer-while": "error",
    "sort-imports": "off", // conflicts with prettier
    "space-after-function-name": "off",
    "space-after-keywords": "off",
    "space-before-blocks": "off",
    "space-before-function-paren": "off",
    "space-before-function-parentheses": "off",
    "space-before-keywords": "off",
    "space-in-brackets": "off",
    "space-in-parens": "off",
    "space-infix-ops": "off",
    "space-return-throw-case": "off",
    "space-unary-ops": "off",
    "space-unary-word-ops": "off",
    "spaced-comment": "off",
    "switch-colon-spacing": "off",
    "template-curly-spacing": "off",
    "template-tag-spacing": "off",
    "unicode-bom": "off",
    "unicorn/catch-error-name": "error",
    "unicorn/consistent-function-scoping": "error",
    "unicorn/custom-error-definition": "warn",
    "unicorn/error-message": "error",
    "unicorn/escape-case": "error",
    "unicorn/expiring-todo-comments": "error",
    "unicorn/explicit-length-check": "error",
    "unicorn/filename-case": "error",
    "unicorn/import-index": "error",
    "unicorn/new-for-builtins": "error",
    "unicorn/no-abusive-eslint-disable": "warn",
    "unicorn/no-array-instanceof": "error",
    "unicorn/no-console-spaces": "error",
    "unicorn/no-fn-reference-in-iterator": "warn",
    "unicorn/no-for-loop": "error",
    "unicorn/no-hex-escape": "error",
    "unicorn/no-keyword-prefix": "warn",
    "unicorn/no-nested-ternary": "error",
    "unicorn/no-new-buffer": "error",
    "unicorn/no-process-exit": "error",
    "unicorn/no-unreadable-array-destructuring": "error",
    "unicorn/no-unsafe-regex": "warn",
    "unicorn/no-unused-properties": "warn",
    "unicorn/no-zero-fractions": "error",
    "unicorn/number-literal-case": "off", // conflicts with prettier
    "unicorn/prefer-add-event-listener": "error",
    "unicorn/prefer-dataset": "error",
    "unicorn/prefer-event-key": "error",
    "unicorn/prefer-flat-map": "error",
    "unicorn/prefer-includes": "error",
    "unicorn/prefer-modern-dom-apis": "error",
    "unicorn/prefer-negative-index": "error",
    "unicorn/prefer-node-append": "error",
    "unicorn/prefer-node-remove": "error",
    "unicorn/prefer-query-selector": "error",
    "unicorn/prefer-reflect-apply": "error",
    "unicorn/prefer-replace-all": "warn",
    "unicorn/prefer-spread": "error",
    "unicorn/prefer-starts-ends-with": "error",
    "unicorn/prefer-string-slice": "error",
    "unicorn/prefer-text-content": "error",
    "unicorn/prefer-trim-start-end": "error",
    "unicorn/prefer-type-error": "error",
    "unicorn/prevent-abbreviations": "off", // Might be useful one day...
    "unicorn/throw-new-error": "error",
    "wrap-iife": "off",
    "wrap-regex": "off",
    "yield-star-spacing": "off",
    "yoda": "off"
  },
  "settings": {
    "import/resolver": {
      "node": {
        "extensions": [".js", ".jsx", ".ts", ".tsx"],
        "moduleDirectory": ["node_modules", "src/"],
      },
    }
  }
}