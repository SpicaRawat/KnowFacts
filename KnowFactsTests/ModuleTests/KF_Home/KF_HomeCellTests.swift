//
//  KF_HomeCellTests.swift
//  KnowFactsTests
//
//  Created by Spica Rawat on 20/09/20.
//  Copyright © 2020 spicarawat. All rights reserved.
//

import XCTest
@testable import KnowFacts

class KF_HomeCellTests: XCTestCase {

    var cell: KF_HomeCell!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cell = KF_HomeCell()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cell = nil
    }

    func testBindDataWithNotNilData() {
        let fact = getDummyData()
        cell.bindData(fact: fact.rows[0])
        XCTAssertFalse((cell.descLbl.text?.isEmpty) ?? true)
    }
    
    func testBindDataWithNilData() {
        var fact = getDummyData()
        fact.rows[0].title = nil
        cell.bindData(fact: fact.rows[0])
        XCTAssertTrue(cell.titleLbl.text?.isEmpty ?? false)
    }
}
extension KF_HomeCellTests {
    // MARK: - GET DUMMY DATA FOR TEST
    func getDummyData() -> FactsData {
        let fact = FactsData(title: "About India", rows: [Fact(title: "Language", description: "Hindi", imageHref: nil)])
        return fact
    }
}

