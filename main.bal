import ballerina/io;
import ballerina/http;
public function main() returns http:ClientError? {
    http:Client clientEp = check new("https://api.staging-central.ballerina.io/2.0/registry/packages/choreouptime/rest_api_1694686286/");
    http:Response meow = check clientEp->get("/1.0.0?user-packages=true");
    io:println(meow.statusCode);
}
