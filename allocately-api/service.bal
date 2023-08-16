import ballerina/http;

service /api on new http:Listener(9090) {

    int maxAllocation;
    int allocations;

    function init() {
        self.maxAllocation = 0;
        self.allocations = 0;
    }

    isolated resource function get health() returns error?|json {
        return {isLive: true};
    }

    isolated resource function get status() returns StatusResponse|error? {
        return {
            maxAllocation: self.maxAllocation,
            allocations: self.allocations
        };
    }

    isolated resource function post allocations(@http:Payload NewAllocationsRequest newAllocationReq = {newAllocations: 1}) returns error?|StatusResponse {
        self.allocations += newAllocationReq.newAllocations;
        return {
            maxAllocation: self.maxAllocation,
            allocations: self.allocations
        };
    }

    resource function put max_allocation(@http:Payload MaxAllocationsRequest maxAllocationReq = {maxAllocation: 0}) returns error?|StatusResponse {
        self.maxAllocation = maxAllocationReq.maxAllocation;
        return {
            maxAllocation: self.maxAllocation,
            allocations: self.allocations
        };
    }
}

type StatusResponse record {|
    int? maxAllocation;
    int? allocations;
|};

type NewAllocationsRequest record {|
    int newAllocations;
|};

type MaxAllocationsRequest record {|
    int maxAllocation;
|};
