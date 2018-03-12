# SonarQube Connector

The SonarQube connector allows you to access the SonarQubue REST API through ballerina and get a list of past line coverage measures.


## Getting started

1. Download the Ballerina tool distribution by navigating https://ballerinalang.org/downloads/
2. Copy ballerina-sonarqube-{VERSION}.jar into the `<ballerina-tools>/bre/lib` folder.

##### Prerequisites
1. Obtain the following parameters by visiting  [https://wso2.org/sonar/](https://wso2.org/sonar/):
    * username
    * password
    * component name ex- analytics-apim

## Running sample

##### Invoke the actions

- Copy `connector-sonarqube/component/samples/samples.bal` file and paste it into `<ballerina-tools>/bin` folder.
- Run the following commands to get a list of line coverage measures for a component and a product.

  1. **getLatestComponentLineCoverage:**
  
  `bin$ ./ballerina run samples.bal getLatestComponentLineCoverage <username> <password> <component_name>`
  
  2. **getLatestProductLineCoverage:**
    
    `bin$ ./ballerina run samples.bal getLatestProductLineCoverage <username> <password> <product_name> <database_host> <database_port> <database_name> <database_username> <database_password> <database_table>`
    
    ###### <product name>
      * API Management
      * Automation
      * Ballerina
      * Cloud
      * Identity and Access Management
      * Integration
      * IoT
      * Platform
      * Platform Extension
      * Streaming Analytics
     ####
    To execute this method you first need to create a sql database and insert [this](https://drive.google.com/file/d/11EdiPViLcBKvz3u-DbRi2Zo8l5D9QCK8/view?usp=sharing) table to the database.Then execute the ballerina run command with necessary credentials.

| Ballerina Version | SonarQube Connector Version |
| ----------------- | ---------------------- |
| 0.962.0 | 1.0-SNAPSHOT |
