import ballerina/http;

service / on new http:Listener(9090) {
    resource function get hello() returns int|error {
        http:Client albumClient = check new ("https://api.staging-central.ballerina.io/2.0/registry/packages/choreouptime/rest_api_1694686286/");
        http:Response resp = check albumClient->get("1.0.0?user-packages=true");    
        return resp.statusCode;
    }
}
