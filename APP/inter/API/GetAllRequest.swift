import API

struct GetAllRequest: APIRequest {
    typealias Response = [GetAllResponse]

    var httpMethod: APIHTTPMethod {
        .get
    }

    var resourceName: String {
        "independent"
    }
}
