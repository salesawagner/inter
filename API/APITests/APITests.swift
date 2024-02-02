//
//  APITests.swift
//  APITests
//
//  Created by Wagner Sales on 05/12/23.
//

import XCTest
import API

final class APITests: XCTestCase {
    func test_list() throws {
        let expectation = XCTestExpectation(description: "test_list")
        let api = WASAPI(environment: Environment.local)
        api.send(GetAllRequest()) { result in
            switch result {
            case .success(let response): XCTAssertEqual(response.count, 20)
            case .failure(let error): XCTFail(error.localizedDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }
}
