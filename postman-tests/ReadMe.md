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

To run using newman use either of the 2 commands below after changing to the collections directory. The second command uses built in newman-reporters to format output.

    newman run cqf-measures.postman_collection.json -e workspace.postman_globals.json    

    newman run cqf-measures.postman_collection.json -e workspace.postman_globals.json --reporters cli,json --reporter-json-export output.json

#### Automation

The newman tests have been automated and a different reporting format used specifically for VSAC. To use this change to the directory postman-tests/automation.
Run  npm install -g date-fns --save
You may have to run npm install after this to make sure the package is there for node to use it.

There are default parameters in the program that can be set on the commandline.
    
    Output directory: './' (current directory).
    The path and file name of the Postman collection file: '../collections/cqf-measures.postman_collection.json'
    The path and file name of the environment file where the username and password are set: '../collections/workspace.postman_globals.json';

These will be used unless changed on the command line as (notice no space after the '='). Any that are missing will use the default settings. THe output file name will be testResults_yyyyMMddhhmm (year + month + day of year + hour + minute of the beginning of the test run) 

    -op=<your output location>
    -cs=<the collection location and file name>
    -es=<the environment settings location and file name>

So the command line would be 

    node newman-reporter-vsac.js -cs=/user/postman/collections/newCollection.json -es=/user/postman/collections/postmanEnvironment.json -op=/user/postman/tests

Output will be sent to the console and after running this there should be a new file /user/postman/tests/testResults_202309140125.json that contains the results.
