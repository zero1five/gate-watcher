module.exports = {
  testRegex:
    "(/[^.history]/src/__test__/.*|(\\.|/)(test|spec))\\.(coffee|jsx?)$",
  moduleFileExtensions: ["coffee", "js"],
  transform: {
    "^.+\\.jsx?$": "<rootDir>/node_modules/babel-jest",
    "^.+\\.coffee$": "<rootDir>/node_modules/jest-coffee-preprocessor/index.js"
  }
};
