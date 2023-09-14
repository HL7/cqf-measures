const newman = require('newman');
const customReporter = require('newman-reporter-htmlextra');

// Define your custom reporter function
function CustomReporter(options) {
  customReporter.call(this, options);
}

// Extend the custom reporter
CustomReporter.prototype = new customReporter();

// Add custom functionality to the reporter
CustomReporter.prototype.summary = function (summary) {
  console.log('Custom Newman Reporter - Test Summary:');
  console.log(`Total Requests: ${summary.run.stats.requests.total}`);
  console.log(`Total Tests: ${summary.run.stats.tests.total}`);
  console.log(`Total Passed: ${summary.run.stats.tests.passes}`);
  console.log(`Total Failed: ${summary.run.stats.tests.failures}`);
};

// Register the custom reporter
newman.exports.push({ name: 'custom-reporter', reporter: CustomReporter });

// Run Newman with your custom reporter
newman.run({
  collection: '../collections/cqf-measures.postman_collection.json', // Replace with your collection path
  environment: require('../collections/workspace.postman_globals.json'),
  reporters: ['custom-reporter'],
}, (err) => {
  if (err) {
    console.error('Newman run encountered an error:', err);
  } else {
    console.log('Newman run completed successfully.');
  }
});