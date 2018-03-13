# Ballerina SonarQube Connector

*SonarQube is an open source platform developed by SonarSource for continuous inspection of code quality to perform automatic reviews with static analysis of code to detect bugs, code smells and security vulnerabilities on 20+ programming languages including Java (including Android), C#, PHP, JavaScript, C/C++, COBOL, PL/SQL, PL/I, ABAP, VB.NET, VB6, Python, RPG, Flex, Objective-C, Swift, Web and XML.* (https://www.sonarqube.org/).

![Ballerina -SonarQube Connector Overview](BallerinaEthereumJSONRPC.png)

The following sections provide you with information on how to use the Ballerina SonarQube connector.

- [Getting started](#getting-started)
- [Running Samples](#running-samples)
- [Quick Testing](#quick-testing)
- [Working with sonarqube connector actions](#working-with-ethereum-connector-actions)

## Getting started

1. Create a ServerCredentials.conf file with following SonarQube server credentials.
- serverURL - SonarQube server URL
- authType - Authentication type (user or token)
- username - Your SonarQube account username.If the authentication type is "user" this parameter must be specified.
- password - Your SonarQube account password.If the authentication type is "user" this parameter must be specified.
- token - If the authentication type is "token" this parameter must be specified.

##### Prerequisites
1. Enable JSON RPC API in your Ethereum client node by visiting [https://github.com/ethereum/wiki/wiki/JSON-RPC/](https://github.com/ethereum/wiki/wiki/JSON-RPC#javascript-api).
2. Identify the URI for the JSON RPC server.
Default JSON-RPC endpoints:

| Client | URL |
|-------|:------------:|
| C++ |  http://localhost:8545 |
| Go |http://localhost:8545 |
| Py | http://localhost:4000 |
| Parity | http://localhost:8545 |

## Running Samples

- Copy the `connector-ethereum/component/samples/ethereum/sampleDashBoard.bal` file and paste it into the `<ballerina-tools>/bin` folder.
- Run the following command to execute the sample.
    `bin$ ballerina run sampleDashBoard.bal <URI> <JSONRPCVersion> <NetworkID>`

    E.g., `bin$ ballerina run sampleDashBoard.bal "http://localhost:8080" "2.0" 1999`
    
## Quick Testing

You can easily test the following actions using the `sample.bal` file.

- Copy `connector-ethereum/component/samples/ethereum/sample.bal` file and paste it into `<ballerina-tools>/bin` folder.
- Run the following commands to execute the sample.
    `bin$ ballerina run sample.bal <URI> <JSONRPCVersion> <NetworkID> <MethodName> <Param1> .. <ParamN>`

## Working with sonarqube connector actions


##### Related Ethereum Documentation

https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_submithashrate

***


#### Related links
- https://github.com/ethereum/wiki/wiki/JSON-RPC