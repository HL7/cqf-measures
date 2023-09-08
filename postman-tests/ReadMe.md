 # Postman Testing
 ## Running the collection from within Postman
 ### Environment Variables
 In Postman setup the following environment variables. They are used in the queries in this collection.

 basicUser:  your UserName for the VSAC server

 basicPass:  your password for the VSAC server

 VSAC_URL:   which should be https://uat-cts.nlm.nih.gov/fhir/

 ### Running the tests

 Import the collection in Postman. 

 After setting up the variables, double click the query you want to run from the collection. Check the results. Edit as desired and rerun. Rinse and repeat. 
 
 
 
 
### Running the collection from CLI
 ### Install Newman
 
 Following the directions to install newman and newman-reporter-html

[Newman](https://learning.postman.com/docs/collections/using-newman-cli/command-line-integration-with-newman/)

 npm install -g newman

 [newman-reporter-html](https://www.npmjs.com/package/newman-reporter-html)

 npm install -g newman-reporter-htmlextra

### Setting up the environment variables

Open the file workspace.postman_globals.json. Edit the values for basicUser and basicPass so they have the actual username and password for the VSAC uat-cts server. 

### Running the tests

newman run cqf-measures.postman_collection.json -e workspace.postman_globals.json    

newman run cqf-measures.postman_collection.json -e workspace.postman_globals.json --reporters cli,json --reporter-json-export output.json