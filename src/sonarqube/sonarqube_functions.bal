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

import ballerina.net.http;
import ballerina.time;

@Description {value:"Check whether the response from sonarqube server has an error field."}
@Param {value:"response: http InResponse."}
@Return {value:"errorMessage: If the response payload consists of an error field return it."}
function checkResponse (http:InResponse response) (error) {
    json responseJson = getContentByKey(response, ERRORS);
    error err;
    if (responseJson != null) {
        err = {};
        err.message = "";
        foreach item in responseJson {
            err.message = err.message + ((item.msg != null) ? item.msg.toString() : "") + ".";
        }
    }
    return err;
}

@Description {value:"Get content from a json specified by key."}
@Param {value:"response: http InResponse."}
@Param {value:"key: String key."}
@Return {value:"jsonPayload: Content of type json specified by key."}
function getContentByKey (http:InResponse response, string key) (json) {
    var jsonPayload, err = response.getJsonPayload();
    if (err != null) {
        return {};
    }
    if (key == "") {
        return jsonPayload;
    }
    return jsonPayload[key];
}

@Description {value:"Returns value of the metric in measures field of a json."}
@Param {value:"response: http InResponse."}
@Return {value:"value: Value of the metric field in json."}
@Return {value:"err: if error occured in getting value of the measures field in the json."}
function getMetricValue (string projectKey, string metricName) (string, error) {
    endpoint<http:HttpClient> sonarqubeEP {
        getHTTPClient();
    }
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError httpError;
    error err = null;
    constructAuthenticationHeaders(request);
    string requestPath = API_MEASURES + "?" + COMPONENT_KEY + "=" + projectKey + "&" + METRIC_KEY + "=" + metricName;
    response, httpError = sonarqubeEP.get(requestPath, request);
    if (httpError != null) {
        err = {message:httpError.message};
        return null, err;
    }
    error httpResponseError = checkResponse(response);
    if (httpResponseError != null) {
        err = httpResponseError;
        return null, err;
    }
    json component = getContentByKey(response, COMPONENT);
    if (component == null) {
        err = {message:"Metric definitions for this project cannot be found"};
        return null, err;
    }
    json metricValue = component[MEASURES][0][VALUE];
    string value = (metricValue != null) ? metricValue.toString() : null;
    if (value == null) {
        err = {message:"Cannot find " + metricName.replace("_", " ") + " for this project"};
        return null, err;
    }
    return value, err;
}

@Description {value:"Returns key of a project."}
@Param {value:"response: http InResponse."}
@Param {value:"projectName : project name."}
@Return {value:"projectKey: key of a project."}
@Return {value:"err: if error occured in getting key of a project."}
function getProjectKey (http:InResponse response, string projectName) (string, error) {
    error err;
    error httpResponseError = checkResponse(response);
    if (httpResponseError != null) {
        return null, httpResponseError;
    }
    string projectKey;
    json allProducts = getContentByKey(response, "");
    if (allProducts == null) {
        err = {message:"Cannot get the product list form sonarqube server"};
        return null, err;
    }
    int lengthOfProducts = lengthof allProducts;
    if (lengthOfProducts == 0) {
        err = {message:"Projects cannot be found in sonarqube server"};
        return null, err;
    }
    foreach product in allProducts {
        Project project = <Project, getProjectDetails()>product;
        if (project.name == projectName) {
            projectKey = project.key;
            if (projectKey == null) {
                err = {message:"Project specified by name " + projectName + "cannot be found in sonarqube server"};
                return null, err;
            }
            return projectKey, err;
        }
    }
    err = {message:"Project specified by name " + projectName + "cannot be found in sonarqube server"};
    return null, err;
}

@Description {value:"Get operation details."}
@Param {value:"name:Name of the operation."}
@Param {value:"status:Operation status"}
@Return {value:"operation: Returns struct Operation containing operation details."}
function getOperation (string name, string status, any additionalInformation) (Operation) {
    Operation operation = {};
    operation.name = name;
    operation.status = status;
    Comment comment = {};
    Issue issue = {};
    type commentType = typeof comment;
    type issueType = typeof issue;
    if (typeof additionalInformation == commentType) {
        comment, _ = (Comment)additionalInformation;
        operation.details = name + " " + comment.text + " on issue is " + status + ".";
        operation.createdDate = comment.createdDate;
    } else if (typeof additionalInformation == issueType) {
        issue, _ = (Issue)additionalInformation;
        if (name == ASSIGN) {
            operation.details = name + " " + issue.assignee + " on issue is " + status + ".";
        } else if (name == SET_TYPE) {
            operation.details = name + " " + issue.|type| + " on issue is " + status + ".";
        } else if (name == SET_SEVERITY) {
            operation.details = name + " " + issue.severity + " on issue is " + status + ".";
        } else if (name == SET_STATUS) {
            operation.details = name + " " + issue.status + " on issue is " + status + ".";
        }
        time:Time time = time:currentTime();
        operation.createdDate = time.toString();
    }
    return operation;
}