
# CQF Measure Terminology Service Postman Test Collection

## Running the collection from within Postman

### Environment Variables
In Postman set up the following environment variables. They are used in the queries in this collection.

basicUser:  your UserName for the target server

basicPass:  your password for the target server

SERVER_URL:   The url of the server being tested for compliance to the [CQF Measure Terminology Service](https://build.fhir.org/ig/HL7/cqf-measures/measure-terminology-service.html) compliance to the IG specification.

### Running the tests

Import the collection in Postman. 

After setting up the variables, double-click the query you want to run from the collection. Check the results. Edit as desired and rerun. Rinse and repeat. 
 
## Running the collection from CLI

### Install Newman
 
Following the directions to install [Newman](https://learning.postman.com/docs/collections/using-newman-cli/command-line-integration-with-newman/)

    npm i -g newman

Additional [third party newman reporters](https://www.npmjs.com/search?q=newman-reporter) are available to install. This list is maintained by npm.

### Setting up the environment variables

Open the file workspace.postman_globals.json. Edit the values for basicUser, basicPass, and SERVER_URL, so they have the actual username, password, and server url for the target server. The other global variable has the key of VERSION. This defaults to STU4, but may be changed to STU5 to test that release by adjusting the profile testing to use CRMI. 

### Running the tests

To run using newman use the command below after changing to the collections directory.

    newman run cqf-measures.postman_collection.json -e ../workspace.postman_globals.json    

### Debugging the tests
There are several options to figure out why a test is failing. The console output shows which tests are failing, a summary of the results, and the assertion errors with a brief mention as to what failed.

As an alternative, the request to the server may be made from Postman itself and the response reviewed and compared with the test.

The third option  is to turn on the following flags in the globals.json file:

    CODESYSTEM_DEBUG
    VALUESET_DEBUG
    QUALITY_PROGRAM_DEBUG
    SERVER_DEBUG
    CAPABILITY_DEBUG

These cause the actual response from the server to be output to the console. Each affects the section corresponding to the flag name. They can be quite verbose, but most errors can be understood with their use. By default, these settings are false.

### Finding sources of truth listed in the collection.
The script _SOT.sh runs through the postman collection and finds all the source of truth references and lists the link in the section they occur. Duplicates are not removed as each entry comes from a different section.

    Usage: bash ./_SOT.sh collections/cqf-measures-terminology-service-tests.postman_collection.json truthSources.md
