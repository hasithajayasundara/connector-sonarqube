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
//src as source root

function main (string[] serverArgs) {
    endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "Siddhi IO MQTT Extension Parent";

    var project, err = sonarqubueConnector.getProject(projectName);
    if (err != null) {
        io:println(err.message);
        return;
    }
    //Get Code quality measurements
    var lineCoverage, err = project.getLineCoverage();
    if (err == null) {
        io:println("Line coverage - " + lineCoverage);
    } else {
        io:println(err.message);
    }

    var branchCoverage, err = project.getBranchCoverage();
    if (err == null) {
        io:println("Branch coverage -" + branchCoverage);
    } else {
        io:println(err);
    }

    var complexity, err = project.getComplexity();
    if (err == null) {
        io:println("Complexity - " + complexity);
    } else {
        io:println(err.message);
    }

    var duplicatedBlocksCount, err = project.getDuplicatedCodeBlocksCount();
    if (err == null) {
        io:println("Duplicated blocks count - " + duplicatedBlocksCount);
    } else {
        io:println(err.message);
    }

    var duplicatedLinesCount, err = project.getDuplicatedLinesCount();
    if (err == null) {
        io:println("Duplicated lines count - " + duplicatedLinesCount);
    } else {
        io:println(err.message);
    }

    var duplicatedFilesCount, err = project.getDuplicatedFilesCount();
    if (err == null) {
        io:println("Duplicated files count - " + duplicatedFilesCount);
    } else {
        io:println(err.message);
    }

    var blockerIssueCount, err = project.getBlockerIssuesCount();
    if (err == null) {
        io:println("Blocker issues count - " + blockerIssueCount);
    } else {
        io:println(err.message);
    }

    var criticalIssueCount, err = project.getCriticalIssuesCount();
    if (err == null) {
        io:println("Critical issues count - " + criticalIssueCount);
    } else {
        io:println(err.message);
    }

    var majorIssueCount, err = project.getMajorIssuesCount();
    if (err == null) {
        io:println("Major issues count - " + majorIssueCount);
    } else {
        io:println(err.message);
    }

    var openIssuesCout, err = project.getOpenIssuesCount();
    if (err == null) {
        io:println("Open issues count - " + openIssuesCout);
    } else {
        io:println(err.message);
    }

    var reopenedIssuesCount, err = project.getReopenedIssuesCount();
    if (err == null) {
        io:println("Reopened issues count - " + reopenedIssuesCount);
    } else {
        io:println(err.message);
    }

    var confirmedIssueCount, err = project.getConfirmedIssuesCount();
    if (err == null) {
        io:println("Confirmed issues count - " + confirmedIssueCount);
    } else {
        io:println(err.message);
    }

    var lines, err = project.getLinesOfCode();
    if (err == null) {
        io:println("Lines of code - " + lines);
    } else {
        io:println(err.message);
    }

    var codeSmellsCount, err = project.getCodeSmellsCount();
    if (err == null) {
        io:println("Code smells count - " + codeSmellsCount);
    } else {
        io:println(err.message);
    }

    var sqaleRating, err = project.getSQALERating();
    if (err == null) {
        io:println("SQALE rating - " + sqaleRating);
    } else {
        io:println(err.message);
    }

    var technicalDebt, err = project.getTechnicalDebt();
    if (err == null) {
        io:println("Technical debt - " + technicalDebt);
    } else {
        io:println(err.message);
    }

    var technicalDebtRatio, err = project.getTechnicalDebtRatio();
    if (err == null) {
        io:println("Technical debt ratio - " + technicalDebtRatio);
    } else {
        io:println(err.message);
    }

    var vulnerabilities, err = project.getVulnerabilitiesCount();
    if (err == null) {
        io:println("Vulnerabilities count - " + vulnerabilities);
    } else {
        io:println(err.message);
    }

    var securityRating, err = project.getSecurityRating();
    if (err == null) {
        io:println("Security Rating - " + securityRating);
    } else {
        io:println(err.message);
    }

    var bugsCount, err = project.getBugsCount();
    if (err == null) {
        io:println("Bugs Count - " + bugsCount);
    } else {
        io:println(err.message);
    }

    var reliabilityRating, err = project.getReliabilityRating();
    if (err == null) {
        io:println("Reliability rating - " + reliabilityRating);
    } else {
        io:println(err.message);
    }

    var projectIssues, err = project.getIssues();
    if (err == null) {
        io:print("Issues - ");
        io:println(projectIssues);
    } else {
        io:println(err.message);
    }

    //Operations on issues
    sonarqube:Issue issue = projectIssues[0];
    err = issue.addComment("This is a critical issue");
    if (err == null) {
        io:println("Adding comment successful.");
    } else {
        io:println(err);
    }

    err = issue.assign("admin");
    if (err == null) {
        io:println("Assigning user to a issue successful.");
    } else {
        io:println(err);
    }

    err = issue.setSeverity("CRITICAL");
    if (err == null) {
        io:println("Setting issue severity successful.");
    } else {
        io:println(err);
    }

    err = issue.setType("CODE_SME");
    if (err == null) {
        io:println("Setting issue type successful.");
    } else {
        io:println(err);
    }

    //Operations on issue comments
    sonarqube:Comment comment = issue.comments[0];
    err = comment.edit("This is a blocker issue");
    if (err == null) {
        io:println("Editing comment successful.");
    } else {
        io:println(err);
    }

    err = comment.delete();
    if (err == null) {
        io:println("Deleting comment successful.");
    } else {
        io:println(err);
    }
}

