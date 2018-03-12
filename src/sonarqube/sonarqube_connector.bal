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

import ballerina.config;
import ballerina.net.http;

@Description {value:"SonarQube client connector."}
public connector SonarqubeConnector () {

    endpoint<http:HttpClient> sonarqubeEP {
        create http:HttpClient(config:getGlobalValue(SERVER_URL), {chunking:"never"});
    }

    @Description {value:"Get project details."}
    @Param {value:"projectName: Name of the project."}
    @Return {value:"project: Returns project struct with projects's key,id,uuid,version and description."}
    @Return {value:"err: returns error if an exception raised in getting project details."}
    action getProject (string projectName) (Project, error) {
        http:OutRequest request = {};
        http:InResponse response = {};
        http:HttpConnectorError httpError;
        error err = null;
        constructAuthenticationHeaders(request);
        response, httpError = sonarqubeEP.get(API_RESOURCES, request);
        if (httpError != null) {
            err = {message:httpError.message};
            return null, err;
        }
        var projectKey, keyError = getProjectKey(response, projectName);
        if (keyError != null) {
            err = keyError;
            return null, err;
        }
        string requestPath = API_SHOW_PROJECT + "?" + KEY + "=" + projectKey;
        response = {};
        request = {};
        constructAuthenticationHeaders(request);
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
            err = {message:"Project specified by " + projectName + " cannot be found in sonarqube server."};
            return null, err;
        }
        Project project = <Project, getProjectDetails()>component;
        return project, err;
    }
}

