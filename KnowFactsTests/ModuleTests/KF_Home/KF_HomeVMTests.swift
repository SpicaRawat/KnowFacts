//
//  KF_HomeVCTests.swift
//  KnowFactsTests
//
//  Created by Spica Rawat on 20/09/20.
//  Copyright © 2020 spicarawat. All rights reserved.
//

import XCTest
@testable import KnowFacts
import OHHTTPStubs
import Alamofire

class FF_HomeVMTests: XCTestCase {

    // MARK: - VARIABLES
    var homeVM: KF_HomeVM!
    var mockReachability: MockReachability!
    var mockapimanager: MockAPIManager!

    override func setUp() {
        mockReachability = MockReachability()
        mockapimanager = MockAPIManager()
        homeVM = KF_HomeVM()
        homeVM.reachability = mockReachability
        homeVM.apiManager = mockapimanager

    }

    override func tearDown() {
        homeVM = nil
        mockReachability = nil
        mockapimanager = nil
    }

    func testGetDataFromServerWithSuccess() {
        homeVM.getDataFromServer()
        XCTAssertTrue(homeVM.facts.count == 1)
    }
    
    func testLoadDataFromServerWithFailure() {
        mockapimanager.errorInResp = true //will return error in API response
        homeVM.getDataFromServer()
        XCTAssertTrue(homeVM.facts.isEmpty)
    }


}
// MARK: - MOCK CONECTIVITY
class MockReachability: Reachability {
    override func isConnectedToInternet() -> Bool {
        return true
    }
}

// MARK: - MOCK API MANAGER
class MockAPIManager: APIManager {
    
    var errorInResp = false

    // MARK: - API TO GET ITEM LIST FROM SERVER
    override func getFactFromServer(url: String, completion: @escaping ((Result<FactsData, AFError>) -> Void)) {
        if errorInResp {
            let error = AFError.invalidURL(url: "")
            completion(AFResult.failure(error))
            return
        } else {
            let fact = getDummyData()
            completion(.success(fact))
        }
    }
    
    func getDummyData() -> FactsData {
        let fact = FactsData(title: "About India", rows: [Fact(title: "Language", description: "Hindi", imageHref: nil)])
        return fact
    }
}
