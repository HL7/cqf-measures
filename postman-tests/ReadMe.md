
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
