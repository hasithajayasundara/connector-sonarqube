//
// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
//

package samples.sonarqube;

import ballerina.io;
import src.sonarqube;

function main (string[] args) {

    endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "Siddhi IO MQTT Extension Parent";

    //get project details
    var project, err = sonarqubueConnector.getProject(projectName);
    if (err == null) {
        io:println(project);
        //line coverage
        var lineCoverage, err = project.lineCoverage();
        if (err == null) {
            io:println(lineCoverage);
        } else {
            io:println("Line coverage - " + err.message);
        }

        //lines
        var lines, err = project.linesOfCode();
        if (err == null) {
            io:println(lines);
        } else {
            io:println(err);
        }

        //get branch coverage
        var branchCoverage, err = project.branchCoverage();
        if (err == null) {
            io:println(branchCoverage);
        } else {
            io:println(err);
        }

        //get number of vulnerabilities
        var vulnerabilities, err = project.vulnerabilitiesCount();
        if (err == null) {
            io:println(vulnerabilities);
        } else {
            io:println(err);
        }

        //get security rating
        var securityRating, err = project.securityRating();
        if (err == null) {
            io:println(securityRating);
        } else {
            io:println(err);
        }

        //get number of bugs
        var numberofBugs, err = project.bugsCount();
        if (err == null) {
            io:println(numberofBugs);
        } else {
            io:println(err);
        }

        //get reliability rating
        var reliabilityRating, err = project.reliabilityRating();
        if (err == null) {
            io:println(reliabilityRating);
        } else {
            io:println(err);
        }

        //get project issues
        var projectIssues, err = project.issues();
        if (err == null) {
            io:println(projectIssues);
        } else {
            io:println(err);
        }

        //add comment on issue
        var commentResponse, err = projectIssues[0].addComment("Commented twice");
        if (err == null) {
            io:println(commentResponse);
        } else {
            io:println(err);
        }

        //assign a user to issue
        var assignResponse, err = projectIssues[0].assign("admin");
        if (err == null) {
            io:println(assignResponse);
        } else {
            io:println("Assign issue - "+err.message);
        }

        //set issue severity
        var severity, err = projectIssues[0].setSeverity("CRITICAL");
        if (err == null) {
            io:println(severity);
        } else {
            io:println(err);
        }

        //set issue type
        var issueType, err = projectIssues[0].setType("CODE_SMELL");
        if (err == null) {
            io:println(issueType);
        } else {
            io:println(err);
        }
    } else {
        io:println("Project error - " + err.message);
    }
}
