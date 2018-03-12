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

package src.sonarqube;

import ballerina.mime;
import ballerina.net.http;

@Description {value:"Get complexity of a project."}
@Return {value:"complexity:Returns complexity of a project.Complexity calculated based on the number of paths through the code."}
@Return {value:"err: Returns error if an exception raised in getting project complexity."}
public function <Project project> complexity () (string, error) {
    var complexity, err = getMetricValue(project.key, COMPLEXITY);
    if (err != null) {
        return null, err;
    }
    return complexity, err;
}

@Description {value:"Get number of duplicated code blocks."}
@Return {value:"duplicatedCodeBlocks:returns number of duplicated code blocks in a project."}
@Return {value:"err: returns error if an exception raised in getting duplicated code blocks count."}
public function <Project project> duplicatedCodeBlocksCount () (int, error) {
    var initVal, err = getMetricValue(project.key, DUPLICATED_BLOCKS);
    if (err != null) {
        return 0, err;
    }
    var duplicatedCodeBlocks, err = <int>initVal;
    return duplicatedCodeBlocks, err;
}

@Description {value:"Get Number of duplicated files."}
@Return {value:"duplicatedFiles:returns number of duplicated files in a project."}
@Return {value:"err: returns error if an exception raised in getting duplicated files count."}
public function <Project project> duplicatedFilesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, DUPLICATED_FILES);
    if (err != null) {
        return 0, err;
    }
    var duplicatedFiles, err = <int>initVal;
    return duplicatedFiles, err;
}

@Description {value:"Number of duplicated lines."}
@Return {value:"duplicatedFiles:returns number of duplicated lines in a project."}
@Return {value:"err: returns error if an exception raised in getting duplicated lines count."}
public function <Project project> duplicatedLinesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, DUPLICATED_LINES);
    if (err != null) {
        return 0, err;
    }
    var duplicatedLines, err = <int>initVal;
    return duplicatedLines, err;
}

@Description {value:"Get details of project issues."}
@Return {value:"issues: returns array of project issues."}
@Return {value:"err: returns error if an exception raised in getting project issues."}
public function <Project project> issues () (Issue[], error) {
    endpoint<http:HttpClient> sonarqubeEP {
        getHTTPClient();
    }
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError httpError;
    error err = null;
    constructAuthenticationHeaders(request);
    string requestPath = API_ISSUES_SEARCH + "?" + PROJECT_KEYS + "=" + project.key + "&" + EXTRA_CONTENT;
    response, httpError = sonarqubeEP.get(requestPath, request);
    if (httpError != null) {
        err = {message:httpError.message};
        return null, err;
    }
    error httpResponseError = checkResponse(response);
    if (httpResponseError != null) {
        return null, httpResponseError;
    }
    Issue[] issues = [];
    json issueList = getContentByKey(response, ISSUES);
    int i = 0;
    foreach issue in issueList {
        Issue issueStruct = <Issue, getIssue()>issue;
        issues[i] = issueStruct;
        i = i + 1;
    }
    return issues, err;
}

@Description {value:"Number of blocker issues in a project.Blocker issue may be a bug with a high probability to impact the
behavior of the application in production: memory leak, unclosed JDBC connection, .... The code MUST be immediately fixed."}
@Return {value:"blockerIssue:returns number of blocker issues in a project."}
@Return {value:"err: returns error if an exception raised in getting blocker issues count."}
public function <Project project> blockerIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_BLOCKER);
    if (err != null) {
        return 0, err;
    }
    var blockerIssues, err = <int>initVal;
    return blockerIssues, err;
}

@Description {value:"Number of critical issues in a project.Either a bug with a low probability to impact the behavior of the application
in production or an issue which represents a security flaw: empty catch block, SQL injection, ... The code MUST be immediately reviewed. "}
@Return {value:"criticalIssue:returns number of critical issues in a project."}
@Return {value:"err: returns error if an exception raised in getting critical issues count."}
public function <Project project> criticalIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_CRITICAL);
    if (err != null) {
        return 0, err;
    }
    var criticalIssues, err = <int>initVal;
    return criticalIssues, err;
}

@Description {value:"Number of major issues in a project.Quality flaw which can highly impact the developer productivity: uncovered piece
of code, duplicated blocks, unused parameters, ..."}
@Return {value:"minorIssue:returns number of minor issues in a project."}
@Return {value:"err: returns error if an exception raised in getting major issues count."}
public function <Project project> majorIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_MAJOR);
    if (err != null) {
        return 0, err;
    }
    var majorIssues, err = <int>initVal;
    return majorIssues, err;
}

@Description {value:"Number of minor issues in a project.Quality flaw which can slightly impact the developer productivity: lines should not
 be too long, switch statements should have at least 3 cases, ..."}
@Return {value:"majorIssue:returns number of major issues in a project."}
@Return {value:"err: returns error if an exception raised in getting minor issues count."}
public function <Project project> minorIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_MINOR);
    if (err != null) {
        return 0, err;
    }
    var minorIssues, err = <int>initVal;
    return minorIssues, err;
}

@Description {value:"Number of open issues in a project."}
@Return {value:"issuesCount:returns number of open issues in a project."}
@Return {value:"err: returns error if an exception raised in getting open issues count."}
public function <Project project> openIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_OPEN);
    if (err != null) {
        return 0, err;
    }
    var openIssues, err = <int>initVal;
    return openIssues, err;
}

@Description {value:"Number of confirmed issues in a project."}
@Return {value:"confirmedIssues:returns number of confirmed issues in a project"}
@Return {value:"err: returns error if an exception raised in getting confirmed issue count."}
public function <Project project> confirmedIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_CONFIRMED);
    if (err != null) {
        return 0, err;
    }
    var confirmedIssues, err = <int>initVal;
    return confirmedIssues, err;
}

@Description {value:"Number of reopened issues in a project."}
@Return {value:"reopenedIssues:returns number of reopened issues in a project."}
@Return {value:"err: returns error if an exception raised in getting re-opened issue count."}
public function <Project project> reopenedIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_REOPENED);
    if (err != null) {
        return 0, err;
    }
    var reopenedIssues, err = <int>initVal;
    return reopenedIssues, err;
}

@Description {value:"Get lines of code of a project."}
@Return {value:"loc: returns project LOC."}
@Return {value:"err: returns error if an exception raised in getting project LOC."}
public function <Project project> linesOfCode () (int, error) {
    var initVal, err = getMetricValue(project.key, LOC);
    if (err != null) {
        return 0, err;
    }
    var loc, err = <int>initVal;
    return loc, err;
}

@Description {value:"Get line coverage of a project."}
@Return {value:"lineCoverage:returns line coverage of a project."}
@Return {value:"err: returns error if an exception raised in getting line coverage."}
public function <Project project> lineCoverage () (string, error) {
    var lineCoverage, err = getMetricValue(project.key, LINE_COVERAGE);
    if (err != null) {
        return null, err;
    }
    return lineCoverage + "%", err;
}

@Description {value:"Get branch coverage of a project."}
@Return {value:"branchCoverage:returns branch Coverage of a project."}
@Return {value:"err: returns error if an exception raised in getting branch coverage."}
public function <Project project> branchCoverage () (string, error) {
    var branchCoverage, err = getMetricValue(project.key, BRANCH_COVERAGE);
    if (err != null) {
        return null, err;
    }
    return branchCoverage + "%", err;
}

@Description {value:"Get number of code smells in a project.Code smell, (or bad smell) is any symptom in the source code of a program that
possibly indicates a deeper problem."}
@Return {value:"codeSmells: returns number of code smells in a project."}
@Return {value:"err: returns error if an exception raised in getting code smells count."}
public function <Project project> codeSmellsCount () (int, error) {
    var initVal, err = getMetricValue(project.key, CODE_SMELLS);
    if (err != null) {
        return 0, err;
    }
    var codeSmells, _ = <int>initVal;
    return codeSmells, err;
}

@Description {value:"Get SQALE rating of a project.This is the rating given to your project related to the value of your Technical Debt
Ratio."}
@Return {value:"sqaleRating:returns sqale rating of a project."}
@Return {value:"err: returns error if an exception raised in getting SQALE rating."}
public function <Project project> SQALERating () (string, error) {
    var sqaleRating, err = getMetricValue(project.key, SQALE_RATING);
    if (err != null) {
        return null, err;
    }
    var val, _ = <int>sqaleRating;
    if (val <= 5) {
        sqaleRating = "A";
    } else if (val <= 10) {
        sqaleRating = "B";
    } else if (val <= 20) {
        sqaleRating = "C";
    } else if (val <= 50) {
        sqaleRating = "D";
    } else {
        sqaleRating = "E";
    }
    return sqaleRating, err;
}

@Description {value:"Get technical debt of a project.Technical debt is the effort to fix all maintainability issues."}
@Return {value:"technicalDebt: returns technical debt of a project."}
@Return {value:"err: returns error if an exception raised in getting technical debt."}
public function <Project project> technicalDebt () (string, error) {
    var technicalDebt, err = getMetricValue(project.key, TECHNICAL_DEBT);
    if (err != null) {
        return null, err;
    }
    return technicalDebt, err;
}

@Description {value:"Get technical debt ratio of a project."}
@Return {value:"technicalDebtRatio: returns technical debt ratio of a project."}
@Return {value:"err: returns error if an exception raised in getting technical debt ratio."}
public function <Project project> technicalDebtRatio () (string, error) {
    var technicalDebtRatio, err = getMetricValue(project.key, TECHNICAL_DEBT_RATIO);
    if (err != null) {
        return null, err;
    }
    return technicalDebtRatio, err;
}

@Description {value:"Get number of vulnerablities of a project."}
@Return {value:"vulnerabilities: returns number of vulnerabilities of  project."}
@Return {value:"err: returns error if an exception raised in getting vulnerabilities count."}
public function <Project project> vulnerabilitiesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, VULNERABILITIES);
    if (err != null) {
        return 0, err;
    }
    var vulnerabilities, err = <int>initVal;
    return vulnerabilities, err;
}

@Description {value:"Get security rating of a project."}
@Return {value:"securityRating:returns 	security rating of a project."}
@Return {value:"err: returns error if an exception raised in getting security rating."}
public function <Project project> securityRating () (string, error) {
    var securityRating, err = getMetricValue(project.key, SECURITY_RATING);
    if (err != null) {
        return null, err;
    }
    if (securityRating == NO_VULNERABILITY) {
        securityRating = "A";
    } else if (securityRating == MINOR_VULNERABILITY) {
        securityRating = "B";
    } else if (securityRating == MAJOR_VULNERABILITY) {
        securityRating = "C";
    } else if (securityRating == CRITICAL_VULNERABILITY) {
        securityRating = "D";
    } else if (securityRating == BLOCKER_VULNERABILITY) {
        securityRating = "E";
    } else {
        err = {message:"Vulnerability is not properly defined for this project"};
    }
    return securityRating, err;
}

@Description {value:"Get number of bugs in a project."}
@Return {value:"bugs: returns number of bugs of  project."}
@Return {value:"err: returns error if an exception raised in getting bugs count."}
public function <Project project> bugsCount () (int, error) {
    var initVal, err = getMetricValue(project.key, BUGS);
    if (err != null) {
        return 0, err;
    }
    var bugs, err = <int>initVal;
    return bugs, err;
}

@Description {value:"Get reliability rating of a project."}
@Return {value:"securityRating:returns reliability rating of a project."}
@Return {value:"err: returns error if an exception raised in getting reliability rating."}
public function <Project project> reliabilityRating () (string, error) {
    var reliabilityRating, err = getMetricValue(project.key, RELIABILITY_RATING);
    if (err != null) {
        return null, err;
    }
    if (reliabilityRating == NO_BUGS) {
        reliabilityRating = "A";
    } else if (reliabilityRating == MINOR_BUGS) {
        reliabilityRating = "B";
    } else if (reliabilityRating == MAJOR_BUGS) {
        reliabilityRating = "C";
    } else if (reliabilityRating == CRITICAL_BUGS) {
        reliabilityRating = "D";
    } else if (reliabilityRating == BLOCKER_BUGS) {
        reliabilityRating = "E";
    }
    return reliabilityRating, err;
}

@Description {value:"Add a comment on issue."}
@Param {value:"comment: Comment to add."}
@Return {value:"operation: returns Operation struct containing operation details."}
@Return {value:"err: returns error if an exception raised in adding comment."}
public function <Issue issue> addComment (string comment) (Operation, error) {
    endpoint<http:HttpClient> sonarqubeEP {
        getHTTPClient();
    }
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError httpError;
    error err = null;
    json payLoad = {issue:issue.key, text:comment};
    constructAuthenticationHeaders(request);
    request.setHeader(CONTENT_TYPE, mime:APPLICATION_JSON);
    request.setJsonPayload(payLoad);
    response, httpError = sonarqubeEP.post(API_ADD_COMMENT, request);
    if (httpError != null) {
        err = {message:httpError.message};
        return null, err;
    }
    err = checkResponse(response);
    if (err != null) {
        return null, err;
    }
    json serverResponse = getContentByKey(response, COMMENT);
    Comment commentStruct = <Comment, getComment()>serverResponse;
    Operation operation = getOperation(ADDING_COMMENT, SUCCESSFUL, commentStruct);
    return operation, err;
}

@Description {value:"Assign issue."}
@Param {value:"assignee: user name of the person to be assigned."}
@Return {value:"operation: returns Operation struct containing operation details."}
@Return {value:"err: returns error if an exception raised in assigning issue."}
public function <Issue issue> assign (string assignee) (Operation, error) {
    endpoint<http:HttpClient> sonarqubeEP {
        getHTTPClient();
    }
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError httpError;
    error err = null;
    json payLoad = {issue:issue.key, assignee:assignee};
    constructAuthenticationHeaders(request);
    request.setHeader(CONTENT_TYPE, mime:APPLICATION_JSON);
    request.setJsonPayload(payLoad);
    response, httpError = sonarqubeEP.post(API_ASSIGN_ISSUE, request);
    if (httpError != null) {
        err = {message:httpError.message};
        return null, err;
    }
    err = checkResponse(response);
    if (err != null) {
        return null, err;
    }
    json responsePayload = getContentByKey(response, ISSUE);
    Issue issueStruct = <Issue, getIssue()>responsePayload;
    Operation operation = getOperation(ASSIGN, SUCCESSFUL, issueStruct);
    return operation, err;
}

@Description {value:"Set type of an issue."}
@Param {value:"issueType: type of the issue."}
@Return {value:"operation: returns Operation struct containing operation details."}
@Return {value:"err: returns error if an exception raised in setting type of the project."}
public function <Issue issue> setType (string issueType) (Operation, error) {
    endpoint<http:HttpClient> sonarqubeEP {
        getHTTPClient();
    }
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError httpError;
    error err = null;
    json payLoad = {issue:issue.key, |type|:issueType};
    constructAuthenticationHeaders(request);
    request.setHeader(CONTENT_TYPE, mime:APPLICATION_JSON);
    request.setJsonPayload(payLoad);
    response, httpError = sonarqubeEP.post(API_SET_ISSUE_TYPE, request);
    if (httpError != null) {
        err = {message:httpError.message};
        return null, err;
    }
    err = checkResponse(response);
    if (err != null) {
        return null, err;
    }
    json responsePayload = getContentByKey(response, ISSUE);
    Issue issueStruct = <Issue, getIssue()>responsePayload;
    Operation operation = getOperation(SET_TYPE, SUCCESSFUL, issueStruct);
    return operation, err;
}

@Description {value:"Set severity of an issue."}
@Param {value:"severityValue: new severity value."}
@Return {value:"operation: returns Operation struct containing operation details."}
@Return {value:"err: returns error if an exception raised in setting severity of the project."}
public function <Issue issue> setSeverity (string severity) (Operation , error) {
    endpoint<http:HttpClient> sonarqubeEP {
        getHTTPClient();
    }
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError httpError;
    error err = null;
    json payLoad = {issue:issue.key, severity:severity};
    constructAuthenticationHeaders(request);
    request.setHeader(CONTENT_TYPE, mime:APPLICATION_JSON);
    request.setJsonPayload(payLoad);
    response, httpError = sonarqubeEP.post(API_SET_ISSUE_SEVERITY, request);
    if (httpError != null) {
        err = {message:httpError.message};
        return null, err;
    }
    err = checkResponse(response);
    if (err != null) {
        return null, err;
    }
    json responsePayload = getContentByKey(response, ISSUE);
    Issue issueStruct = <Issue, getIssue()>responsePayload;
    Operation operation = getOperation(SET_SEVERITY, SUCCESSFUL, issueStruct);
    return operation, err;
}

@Description {value:"Do workflow transition on an issue."}
@Param {value:"status: transition type to be added."}
@Return {value:"operation: returns Operation struct containing operation details."}
@Return {value:"err: returns error if an exception raised in setting up project status."}
public function <Issue issue> setStatus (string status) (Operation, error) {
    endpoint<http:HttpClient> sonarqubeEP {
        getHTTPClient();
    }
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError httpError;
    error err = null;
    json payLoad = {issue:issue.key, transition:status};
    constructAuthenticationHeaders(request);
    request.setHeader(CONTENT_TYPE, mime:APPLICATION_JSON);
    request.setJsonPayload(payLoad);
    response, httpError = sonarqubeEP.post(API_SET_STATUS, request);
    if (httpError != null) {
        err = {message:httpError.message};
        return null, err;
    }
    err = checkResponse(response);
    if (err != null) {
        return null, err;
    }
    json responsePayload = getContentByKey(response, ISSUE);
    Issue issueStruct = <Issue, getIssue()>responsePayload;
    Operation operation = getOperation(SET_STATUS, SUCCESSFUL, issueStruct);
    return operation, err;
}

@Description {value:"Delete a comment."}
@Return {value:"operation: returns Operation struct containing operation details."}
@Return {value:"err: Returns error if an exception raised in deleting comment."}
public function <Comment comment> delete () (Operation, error) {
    endpoint<http:HttpClient> sonarqubeEP {
        getHTTPClient();
    }
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError httpError;
    error err = null;
    json payLoad = {key:comment.key};
    constructAuthenticationHeaders(request);
    request.setHeader(CONTENT_TYPE, mime:APPLICATION_JSON);
    request.setJsonPayload(payLoad);
    response, httpError = sonarqubeEP.post(API_DELETE_COMMENT, request);
    if (httpError != null) {
        err = {message:httpError.message};
        return null, err;
    }
    err = checkResponse(response);
    if (err != null) {
        return null, err;
    }
    json responsePayload = getContentByKey(response, COMMENT);
    Comment commentStruct = <Comment, getComment()>responsePayload;
    Operation operation = getOperation(DELETE_COMMENT, SUCCESSFUL, commentStruct);
    return operation, err;
}

@Description {value:"Update a comment."}
@Return {value:"operation: returns Operation struct containing operation details."}
@Return {value:"err: returns error if an exception raised in updating comment."}
public function <Comment comment> edit (string newText) (Operation , error) {
    endpoint<http:HttpClient> sonarqubeEP {
        getHTTPClient();
    }
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError httpError;
    error err = null;
    json payLoad = {key:comment.key, text:newText};
    constructAuthenticationHeaders(request);
    request.setHeader(CONTENT_TYPE, mime:APPLICATION_JSON);
    request.setJsonPayload(payLoad);
    response, httpError = sonarqubeEP.post(API_EDIT_COMMENT, request);
    if (httpError != null) {
        err = {message:httpError.message};
        return null, err;
    }
    err = checkResponse(response);
    if (err != null) {
        return null, err;
    }
    json responsePayload = getContentByKey(response, COMMENT);
    Comment commentStruct = <Comment, getComment()>responsePayload;
    Operation operation = getOperation(EDIT_COMMENT, SUCCESSFUL, commentStruct);
    return operation, err;
}