package src.sonarqube;

import ballerina.config;
import ballerina.log;
import ballerina.net.http;
import ballerina.util;

http:HttpClient sonarqubeHTTPClient = null;

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
    if (config:getGlobalValue(AUTH_TYPE) == TOKEN) {
        string token = config:getGlobalValue(USER_TOKEN);
        if (token == null) {
            log:printError("For" + TOKEN + " " + AUTH_TYPE + "a token should be provided");
        } else {
            request.addHeader("Authorization", "Basic " + util:base64Encode(token + ":"));
        }
    } else if (config:getGlobalValue(AUTH_TYPE) == USER) {
        string username = config:getGlobalValue(USERNAME);
        string password = config:getGlobalValue(PASSWORD);
        if (username == null || password == null) {
            if (username == null) {
                log:printError("For" + USER + " " + AUTH_TYPE + "username should be provided");
            }
            if (password != null) {
                log:printError("For" + USER + " " + AUTH_TYPE + "password should be provided");
            }
        } else {
            request.addHeader("Authorization", "Basic " + util:base64Encode(username + ":" + username));
        }
    } else {
        log:printError("Parameter " + AUTH_TYPE + " cannot be found in the configuration file");
    }
}