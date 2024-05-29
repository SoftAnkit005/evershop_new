const config = {
  verbose: true,
  setupFilesAfterEnv: [require.resolve('regenerator-runtime/runtime')],
  testMatch: ['**/packages/evershop/src/**/tests/unit/*.[jt]s?(x)'],
  coveragePathIgnorePatterns: [
    '<rootDir>/.evershop/',
    '<rootDir>/node_modules/',
    '<rootDir>/packages/core/node_modules/'
  ]
};

// Merge with additional Jest configuration
module.exports = {
  ...config,
  testEnvironment: "node",
  modulePathIgnorePatterns: ["<rootDir>/packages_old/"],
  // Other configurations...
};