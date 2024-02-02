//
//  GetByNameRequest.swift
//  inter
//
//  Created by Wagner Sales on 02/02/24.
//

import API

struct GetByNameRequest: APIRequest {
    typealias Response = [GetAllResponse]

    var httpMethod: APIHTTPMethod {
        .get
    }

    var resourceName: String {
        "translation/\(name)"
    }

    @SkipBody var name: String

    init(name: String) {
        self.name = name
    }
}

