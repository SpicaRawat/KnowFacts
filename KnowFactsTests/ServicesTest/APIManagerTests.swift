//
//  APIManagerTests.swift
//  KnowFactsTests
//
//  Created by Spica Rawat on 20/09/20.
//  Copyright © 2020 spicarawat. All rights reserved.
//

import XCTest
@testable import KnowFacts

class APIManagerTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetFactFromServer() {
        APIStub.request(withPathRegex: "dl.dropboxusercontent.com", withResponseFile: "APIResponse.json")
        let expectedResult = expectation(description: "got result")
        APIManager().getFactFromServer(url: "") { result in
            print(result)
            switch result {
            case .success(let fact):
                XCTAssertNotNil(fact.title)
                expectedResult.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error, "Failed to get response from server")
            }
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTAssertNotNil(error, "Failed to get response from server")
            }
        }
    }
    
    func testGetFactFromServerWithErr() {
        APIStub.request(withPathRegex: "dl.dropboxusercontent.com", withResponseFile: "InvalidResponse.json")
        let expectedResult = expectation(description: "got invalid")
        APIManager().getFactFromServer(url: "") { result in
            switch result {
            case .success( let fact):
                XCTAssertNil(fact, "error: item should be nil")
            case .failure(let error):
                XCTAssertNotNil(error, "error: Expectation fulfilled with error")
                expectedResult.fulfill()
            }
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTAssertNotNil(error, "Failed to get response from server")
            }
        }
    }
}
