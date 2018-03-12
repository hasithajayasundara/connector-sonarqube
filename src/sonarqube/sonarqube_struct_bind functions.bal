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
import ballerina.time;

@Description {value:"Get complexity of a project."}
@Return {value:"complexity:Returns complexity of a project."}
@Return {value:"err: Returns error if an exception raised in getting project complexity."}
public function <Project project> complexity () (string, error) {
    var complexity, err = getMetricValue(project.key, COMPLEXITY);
    if (err != null) {
        return null, err;
    }
    return complexity, err;
}

@Description {value:"Get number of duplicated code blocks"}
@Return {value:"duplicatedCodeBlocks:returns number of duplicated code blocks in a project"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> duplicatedCodeBlocksCount () (int, error) {
    var initVal, err = getMetricValue(project.key, DUPLICATED_BLOCKS);
    if (err != null) {
        return 0, err;
    }
    var duplicatedCodeBlocks, err = <int>initVal;
    return duplicatedCodeBlocks, err;
}

@Description {value:"Get Number of duplicated files"}
@Return {value:"duplicatedFiles:returns number of duplicated files in a project"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> duplicatedFilesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, DUPLICATED_FILES);
    if (err != null) {
        return 0, err;
    }
    var duplicatedFiles, err = <int>initVal;
    return duplicatedFiles, err;
}

@Description {value:"Number of duplicated lines"}
@Return {value:"duplicatedFiles:returns number of duplicated lines in a project"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> duplicatedLinesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, DUPLICATED_LINES);
    if (err != null) {
        return 0, err;
    }
    var duplicatedLines, err = <int>initVal;
    return duplicatedLines, err;
}

@Description {value:"Get details of project issues"}
@Return {value:"issues: returns array of project issues"}
@Return {value:"err: returns error if an exception raised"}
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

@Description {value:"Number of blocker issues in a project"}
@Return {value:"blockerIssue:returns number of blocker issues in a project"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> blockerIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_BLOCKER);
    if (err != null) {
        return 0, err;
    }
    var blockerIssues, err = <int>initVal;
    return blockerIssues, err;
}

@Description {value:"Number of critical issues in a project"}
@Return {value:"criticalIssue:returns number of critical issues in a project"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> criticalIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_CRITICAL);
    if (err != null) {
        return 0, err;
    }
    var criticalIssues, err = <int>initVal;
    return criticalIssues, err;
}

@Description {value:"Number of major issues in a project"}
@Return {value:"minorIssue:returns number of minor issues in a project"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> majorIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_MAJOR);
    if (err != null) {
        return 0, err;
    }
    var majorIssues, err = <int>initVal;
    return majorIssues, err;
}

@Description {value:"Number of minor issues in a project"}
@Return {value:"majorIssue:returns number of major issues in a project"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> minorIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_MINOR);
    if (err != null) {
        return 0, err;
    }
    var minorIssues, err = <int>initVal;
    return minorIssues, err;
}

@Description {value:"Number of open issues in a project"}
@Return {value:"issuesCount:returns number of open issues in a project"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> openIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_OPEN);
    if (err != null) {
        return 0, err;
    }
    var openIssues, err = <int>initVal;
    return openIssues, err;
}

@Description {value:"Number of confirmed issues in a project"}
@Return {value:"confirmedIssues:returns number of confirmed issues in a project"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> confirmedIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_CONFIRMED);
    if (err != null) {
        return 0, err;
    }
    var confirmedIssues, err = <int>initVal;
    return confirmedIssues, err;
}

@Description {value:"Number of reopened issues in a project"}
@Return {value:"reopenedIssues:returns number of reopened issues in a project"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> reopenedIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_REOPENED);
    if (err != null) {
        return 0, err;
    }
    var reopenedIssues, err = <int>initVal;
    return reopenedIssues, err;
}

@Description {value:"Get lines of code of a project"}
@Return {value:"loc: returns project LOC"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> linesOfCode () (int, error) {
    var initVal, err = getMetricValue(project.key, LOC);
    if (err != null) {
        return 0, err;
    }
    var loc, err = <int>initVal;
    return loc, err;
}

@Description {value:"Get line coverage of a project"}
@Return {value:"lineCoverage:returns line coverage of a project"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> lineCoverage () (string, error) {
    var lineCoverage, err = getMetricValue(project.key, LINE_COVERAGE);
    if (err != null) {
        return null, err;
    }
    return lineCoverage + "%", err;
}

@Description {value:"Get branch coverage of a project"}
@Return {value:"branchCoverage:returns branch Coverage of a project"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> branchCoverage () (string, error) {
    var branchCoverage, err = getMetricValue(project.key, BRANCH_COVERAGE);
    if (err != null) {
        return null, err;
    }
    return branchCoverage + "%", err;
}

@Description {value:"Get number of code smells in a project"}
@Return {value:"codeSmells: returns number of code smells in a project"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> codeSmellsCount () (int, error) {
    var initVal, err = getMetricValue(project.key, CODE_SMELLS);
    if (err != null) {
        return 0, err;
    }
    var codeSmells, _ = <int>initVal;
    return codeSmells, err;
}

@Description {value:"Get SQALE rating of a project"}
@Return {value:"sqaleRating:returns sqale rating of a project"}
@Return {value:"err: returns error if an exception raised"}
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

@Description {value:"Get technical debt of a project"}
@Return {value:"technicalDebt: returns technical debt of a project"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> technicalDebt () (string, error) {
    var technicalDebt, err = getMetricValue(project.key, TECHNICAL_DEBT);
    if (err != null) {
        return null, err;
    }
    return technicalDebt, err;
}

@Description {value:"Get technical debt ratio of a project"}
@Return {value:"technicalDebtRatio: returns technical debt ratio of a project"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> technicalDebtRatio () (string, error) {
    var technicalDebtRatio, err = getMetricValue(project.key, TECHNICAL_DEBT_RATIO);
    if (err != null) {
        return null, err;
    }
    return technicalDebtRatio, err;
}

@Description {value:"Get number of vulnerablities of a project"}
@Return {value:"vulnerabilities: returns number of vulnerabilities of  project"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> vulnerabilitiesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, VULNERABILITIES);
    if (err != null) {
        return 0, err;
    }
    var vulnerabilities, err = <int>initVal;
    return vulnerabilities, err;
}

@Description {value:"Get security rating of a project"}
@Return {value:"securityRating:returns 	security rating of a project"}
@Return {value:"err: returns error if an exception raised"}
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

@Description {value:"Get number of bugs of a project"}
@Return {value:"bugs: returns number of bugs of  project"}
@Return {value:"err: returns error if an exception raised"}
public function <Project project> bugsCount () (int, error) {
    var initVal, err = getMetricValue(project.key, BUGS);
    if (err != null) {
        return 0, err;
    }
    var bugs, err = <int>initVal;
    return bugs, err;
}

@Description {value:"Get security rating of a project"}
@Return {value:"securityRating:returns 	security rating of a project"}
@Return {value:"err: returns error if an exception raised"}
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

@Description {value:"Add a comment on issue"}
@Param {value:"comment: comment to add"}
@Return {value:"json: returns response json"}
@Return {value:"err: returns error if an exception raised"}
public function <Issue issue> addComment (string comment) (json, error) {
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
    error httpResponseError = checkResponse(response);
    if (httpResponseError != null) {
        return null, httpResponseError;
    }
    return getContentByKey(response, COMMENT), err;
}

@Description {value:"Assign issue"}
@Param {value:"assignee: user name of the person to be assigned"}
@Return {value:"json: returns response json"}
@Return {value:"err: returns error if an exception raised"}
public function <Issue issue> assign (string assignee) (json, error) {
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
    error httpResponseError = checkResponse(response);
    if (httpResponseError != null) {
        return null, httpResponseError;
    }
    json responsePayload = getContentByKey(response, ISSUE);
    time:Time time = time:currentTime();
    return {assignee:assignee, author:(responsePayload[AUTHOR] != null) ? responsePayload[AUTHOR].toString() : "", assignedOn:time.toString()}, err;
}

@Description {value:"Set type of an issue"}
@Param {value:"issueType: type of the issue"}
@Return {value:"json: returns esponse json"}
@Return {value:"err: returns error if an exception raised"}
public function <Issue issue> setType (string issueType) (json, error) {
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
    error httpResponseError = checkResponse(response);
    if (httpResponseError != null) {
        return null, httpResponseError;
    }
    json responsePayload = getContentByKey(response, ISSUE);
    time:Time time = time:currentTime();
    return {issueType:issueType, author:(responsePayload[AUTHOR] != null) ? responsePayload[AUTHOR].toString() : "", createdOn:time.toString()}, err;
}

@Description {value:"Set severity of an issue"}
@Param {value:"severityValue: new severity value"}
@Return {value:"json: returns response json"}
@Return {value:"err: returns error if an exception raised"}
public function <Issue issue> setSeverity (string severity) (json, error) {
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
    error httpResponseError = checkResponse(response);
    if (httpResponseError != null) {
        return null, httpResponseError;
    }
    json responsePayload = getContentByKey(response, ISSUE);
    time:Time time = time:currentTime();
    return {severity:severity, author:(responsePayload[AUTHOR] != null) ? responsePayload[AUTHOR].toString() : "", createdOn:time.toString()}, err;
}

@Description {value:"Do workflow transition on an issue"}
@Param {value:"status: transition type to be added"}
@Return {value:"json: returns response json"}
@Return {value:"err: returns error if an exception raised"}
public function <Issue issue> doWorkFlowTransition (string status) (json, error) {
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
    error httpResponseError = checkResponse(response);
    if (httpResponseError != null) {
        return null, httpResponseError;
    }
    json responsePayload = getContentByKey(response, ISSUE);
    time:Time time = time:currentTime();
    return {issueDescription:responsePayload[MESSAGE], status:status, transition:responsePayload[TRANSITIONS], changedOn:time.toString()}, err;
}

@Description {value:"Delete a comment on issue"}
@Return {value:"json: returns response json"}
@Return {value:"err: returns error if an exception raised"}
public function <Comment comment> delete () (json, error) {
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
    error httpResponseError = checkResponse(response);
    if (httpResponseError != null) {
        return null, httpResponseError;
    }
    json responsePayload = getContentByKey(response, COMMENT);
    return {comment:responsePayload[HTML_TEXT], deletedAt:responsePayload[CREATED_DATE]}, err;
}

@Description {value:"update a comment on issue"}
@Return {value:"json: returns response json"}
@Return {value:"err: returns error if an exception raised"}
public function <Comment comment> edit (string newText) (json, error) {
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
    error httpResponseError = checkResponse(response);
    if (httpResponseError != null) {
        return null, httpResponseError;
    }
    json responsePayload = getContentByKey(response, COMMENT);
    return {previousComment:responsePayload[HTML_TEXT], modifiedComment:newText, modifiedOn:responsePayload[CREATED_DATE]}, err;
}