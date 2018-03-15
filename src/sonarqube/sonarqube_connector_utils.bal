package src.sonarqube;

import ballerina.net.http;
import ballerina.util;

http:HttpClient sonarqubeHTTPClient;

@Description {value:"get sonarqube http client object."}
@Return {value:"sonarqubeHTTPClient: sonarqube http client object."}
public function getHTTPClient () (http:HttpClient) {
    if (sonarqubeHTTPClient == null) {
        sonarqubeHTTPClient = create http:HttpClient(config:getGlobalValue(SERVER_URL), {chunking:"never"});
    }
    return sonarqubeHTTPClient;
}

@Description {value:"Add authentication headers to the HTTP request."}
@Param {value:"request: http OutRequest."}
public function constructAuthenticationHeaders (http:OutRequest request) {
    string username = config:getGlobalValue(USERNAME);
    string password = config:getGlobalValue(PASSWORD);
    if (username == null || password == null) {
        error err = {};
        if (username == null) {
            err = {message:"Username should be provided."};
            throw err;
        }
        if (password != null) {
            err = {message:"Password should be provided."};
            throw err;
        }
    } else {
        request.addHeader("Authorization", "Basic " + util:base64Encode(username + ":" + username));
    }
}
