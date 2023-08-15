import ballerina/http;

service /api on new http:Listener(9090) {
    resource function get .() returns string|error? {
        return "Ok";
    }

    resource function get health() returns error?|json {
        return { isLive: true };
    }
}
