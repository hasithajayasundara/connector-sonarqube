# Ballerina SonarQube Connector

*SonarQube is an open source platform developed by SonarSource for continuous inspection of code quality to perform automatic reviews with static analysis of code to detect bugs, code smells and security vulnerabilities on 20+ programming languages including Java (including Android), C#, PHP, JavaScript, C/C++, COBOL, PL/SQL, PL/I, ABAP, VB.NET, VB6, Python, RPG, Flex, Objective-C, Swift, Web and XML.* (https://www.sonarqube.org/).

![Ballerina -SonarQube Connector Overview](sonarqube-connector.png)

## Compatibility
| Language Version        | Connector Version          | API Version  |
| ------------- |:-------------:| -----:|
| ballerina-0.963.1-SNAPSHOT     | 1.0-SNAPSHOT | 5.6.6,5.6.7 |

The following sections provide you with information on how to use the Ballerina SonarQube connector.

- [Getting started](#getting-started)
- [Quick Testing](#quick-testing)
- [Working with sonarqube connector actions](#working-with-sonarqube-connector-actions)

## Getting started

1. Create a server-config-file-name.conf file with following SonarQube server credentials.
- serverURL - SonarQube server URL
- username - Your SonarQube account username.If the authentication type is "user" this parameter must be specified.
- password - Your SonarQube account password.If the authentication type is "user" this parameter must be specified.

##### Prerequisites
1. Create an account in your SonarQube server.

## Quick Testing

You can easily test the following actions using the `sample.bal` file.
- Run `ballerina run /samples/sonarqube Bballerina.conf=path/to/conf/file/server-config-file-name.conf` from you sonarqube connector directory.

## How to use

***

#### getProject

Get the  details of a project in SonarQube server.

##### Parameters
1. `string` - Project Name

##### Returns

- returns key,id,uuid,version and description of a project.

##### Example

```ballerina
endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "siddhi";
    var project, err = sonarqubueConnector.getProject(projectName);
    if(err != null){
       io:println(err.message);
    }else{
        io:println(project.key);
        io:println(project.id);
        io:println(project.uuid);
        io:println(project.|version|);
        io:println(project.creationDate);
        io:println(project.description);
    }
```

```raw
org.wso2.siddhi:siddhi
46234
AVwQjVWYBabOlhFpojzj
4.1.13-SNAPSHOT
2016-10-20T14:58:30+0530
Siddhi, high performing Complex Event Processing Engine
```

#### getComplexity

Get the complexity of a project.

##### Returns

- returns complexity of a project.

##### Example

```ballerina
endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "siddhi";
    var project, err = sonarqubueConnector.getProject(projectName);
    if(err != null){
        io:println(err.message);
    }else{
        var complexity, err = project.getComplexity();
        if (err == null) {
            io:println("Complexity - " + complexity);
        } else {
            io:println(err.message);
        }
    }
```

```raw
Complexity - 9376
```

#### getdDuplicatedCodeBlocksCount

Get the duplicated code blocks count of a project.

##### Returns

- returns number of duplicated code blocks in a project.

##### Example

```ballerina
endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "siddhi";
    var project, err = sonarqubueConnector.getProject(projectName);
    if(err != null){
        io:println(err.message);
    }else{
        var duplicatedCodeBlocks, err = project.getDuplicatedCodeBlocksCount();
        if (err == null) {
            io:println("Duplicated blocks - " + duplicatedCodeBlocks);
        } else {
            io:println(err.message);
        }
    }
```

```raw
Duplicated blocks - 405
```

#### getDuplicatedLinesCount

Get number of duplicate lines in a project.

##### Returns

- returns number of duplicated lines in a project.

##### Example

```ballerina
endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "siddhi";
    var project, err = sonarqubueConnector.getProject(projectName);
    if(err != null){
        io:println(err.message);
    }else{
        var duplicatedLines, err = project.getDuplicatedLinesCount();
        if (err == null) {
            io:println("Duplicated lines - " + duplicatedLines);
        } else {
            io:println(err.message);
        }
    }
```

```raw
Duplicated lines - 5654
```

#### getDuplicatedFilesCount

Get the number of duplicated files in a project.

##### Returns

- returns number of duplicated files in a project.

##### Example

```ballerina
endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "siddhi";
    var project, err = sonarqubueConnector.getProject(projectName);
    if(err != null){
        io:println(err.message);
    }else{
        var duplicatedFiles, err = project.getDuplicatedFilesCount();
        if (err == null) {
            io:println("Duplicated lines - " + duplicatedFiles);
        } else {
            io:println(err.message);
        }
    }
```

```raw
Duplicated files - 169
```

#### getBlockerIssuesCount

Get number of blocker issues in a project project.Blocker issue may be a bug with a high probability to impact the behavior of the application in production: memory leak, unclosed JDBC connection, .... The code MUST be immediately fixed.

##### Returns

- returns number of blocker issues in a project.

##### Example

```ballerina
endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "siddhi";
    var project, err = sonarqubueConnector.getProject(projectName);
    if(err != null){
        io:println(err.message);
    }else{
        var blockerIssues, err = project.getBlockerIssuesCount();
        if (err == null) {
            io:println("Blocker issues count - " + blockerIssues);
        } else {
            io:println(err.message);
        }
    }
```

```raw
Blocker issues - 36
```

#### getCriticalIssuesCount

Get number of critical issues in a project.

##### Returns

- returns number of critical issues in a project.

##### Example

```ballerina
endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "siddhi";
    var project, err = sonarqubueConnector.getProject(projectName);
    if(err != null){
        io:println(err.message);
    }else{
        var criticalIssues, err = project.getCriticalIssuesCount();
        if (err == null) {
            io:println("Critical issues count - " + criticalIssueCount);
        } else {
            io:println(err.message);
        }
    }
```

```raw
Critical issues - 34
```


#### getMajorIssuesCount

Get number of critical issues in a project.

##### Returns

- returns number of major issues in a project.

##### Example

```ballerina
endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "siddhi";
    var project, err = sonarqubueConnector.getProject(projectName);
    if(err != null){
        io:println(err.message);
    }else{
        var majorIssuesCount, err = project.getMajorIssuesCount();
        if (err == null) {
            io:println("Major issues - " + majorIssuesCount);
        } else {
            io:println(err.message);
        }
    }
```

```raw
Major issues  - 34
```