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

function main (string[] a) {
    endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "Siddhi IO MQTT Extension Parent";

    //get project details
    var project, err = sonarqubueConnector.getProject(projectName);
    if (err != null) {
        io:println(err.message);
    } else {

        var lineCoverage, err = project.lineCoverage();
        if (err == null) {
            io:println("Line coverage - " + lineCoverage);
        } else {
            io:println(err.message);
        }

        var branchCoverage, err = project.branchCoverage();
        if (err == null) {
            io:println("Branch coverage -" + branchCoverage);
        } else {
            io:println(err);
        }

        var complexity, err = project.complexity();
        if (err == null) {
            io:println("Complexity - " + complexity);
        } else {
            io:println(err.message);
        }

        var duplicatedBlocksCount, err = project.duplicatedCodeBlocksCount();
        if (err == null) {
            io:println("Duplicated blocks count - " + duplicatedBlocksCount);
        } else {
            io:println(err.message);
        }

        var duplicatedLinesCount, err = project.duplicatedLinesCount();
        if (err == null) {
            io:println("Duplicated lines count - " + duplicatedLinesCount);
        } else {
            io:println(err.message);
        }

        var duplicatedFilesCount, err = project.duplicatedFilesCount();
        if (err == null) {
            io:println("Duplicated files count - " + duplicatedFilesCount);
        } else {
            io:println(err.message);
        }

        var blockerIssueCount, err = project.blockerIssuesCount();
        if (err == null) {
            io:println("Blocker issues count - " + blockerIssueCount);
        } else {
            io:println(err.message);
        }

        var criticalIssueCount, err = project.criticalIssuesCount();
        if (err == null) {
            io:println("Critical issues count - " + criticalIssueCount);
        } else {
            io:println(err.message);
        }

        var majorIssueCount, err = project.majorIssuesCount();
        if (err == null) {
            io:println("Major issues count - " + majorIssueCount);
        } else {
            io:println(err.message);
        }

        var minorIssueCount, err = project.majorIssuesCount();
        if (err == null) {
            io:println("Minor issues count - " + minorIssueCount);
        } else {
            io:println(err.message);
        }

        var openIssuesCout, err = project.openIssuesCount();
        if (err == null) {
            io:println("Open issues count - " + openIssuesCout);
        } else {
            io:println(err.message);
        }

        var reopenedIssuesCount, err = project.reopenedIssuesCount();
        if (err == null) {
            io:println("Reopened issues count - " + reopenedIssuesCount);
        } else {
            io:println(err.message);
        }

        var confirmedIssueCount, err = project.confirmedIssuesCount();
        if (err == null) {
            io:println("Confirmed issues count - " + confirmedIssueCount);
        } else {
            io:println(err.message);
        }

        var lines, err = project.linesOfCode();
        if (err == null) {
            io:println("Lines of code - " + lines);
        } else {
            io:println(err.message);
        }

        var codeSmellsCount, err = project.codeSmellsCount();
        if (err == null) {
            io:println("Code smells count - " + codeSmellsCount);
        } else {
            io:println(err.message);
        }

        var sqaleRating, err = project.SQALERating();
        if (err == null) {
            io:println("SQALE rating - " + sqaleRating);
        } else {
            io:println(err.message);
        }

        var technicalDebt, err = project.technicalDebt();
        if (err == null) {
            io:println("Technical debt - " + technicalDebt);
        } else {
            io:println(err.message);
        }

        var technicalDebtRatio, err = project.technicalDebtRatio();
        if (err == null) {
            io:println("Technical debt ratio - " + technicalDebtRatio);
        } else {
            io:println(err.message);
        }

        var vulnerabilities, err = project.vulnerabilitiesCount();
        if (err == null) {
            io:println("Vulnerabilities count - " + vulnerabilities);
        } else {
            io:println(err.message);
        }

        var securityRating, err = project.securityRating();
        if (err == null) {
            io:println("Security Rating - " + securityRating);
        } else {
            io:println(err.message);
        }

        var bugsCount, err = project.bugsCount();
        if (err == null) {
            io:println("Bugs Count - " + bugsCount);
        } else {
            io:println(err.message);
        }

        var reliabilityRating, err = project.reliabilityRating();
        if (err == null) {
            io:println("Reliability rating - " + reliabilityRating);
        } else {
            io:println(err.message);
        }

        var projectIssues, err = project.issues();
        if (err == null) {
            io:print("Issues - ");
            io:println(projectIssues);
        } else {
            io:println(err.message);
        }

        var comment, err = projectIssues[0].addComment("This is a critical issue");
        if (err == null) {
            io:println("Adding comment - " + comment.details);
        } else {
            io:println(err.message);
        }

        var assign, err = projectIssues[0].assign("admin");
        if (err == null) {
            io:println("Assign comment - " + assign.details);
        } else {
            io:println(err.message);
        }

        var setSeverity, err = projectIssues[0].setSeverity("CRITICAL");
        if (err == null) {
            io:println("Set Severity - " + setSeverity.details);
        } else {
            io:println(err.message);
        }

        var setissueType, err = projectIssues[0].setType("CODE_SMELL");
        if (err == null) {
            io:println("Set issue type - " + setissueType.details);
        } else {
            io:println(err.message);
        }

        var editComment, err = projectIssues[0].comments[0].edit("This is a blocker issue");
        if (err == null) {
            io:println("Edit comment - " + editComment.details);
        } else {
            io:println(err.message);
        }

        var deleteComment, err = projectIssues[0].comments[0].delete();
        if (err == null) {
            io:println("Delete comment - " + deleteComment.details);
        } else {
            io:println(err.message);
        }
    }
}
