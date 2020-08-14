//
//  CVExampleMockTests.swift
//  CVExampleAppTests
//
//  Created by Denis Sushkov on 14.08.2020.
//  Copyright © 2020 Denis Sushkov. All rights reserved.
//

import XCTest
@testable import CVExampleApp

class CVExampleMockTests: XCTestCase {

    var sut: APIManager!

    override func setUpWithError() throws {
        super.setUp()
        sut = APIManager()
    }

    func testParsesData() {
      // given
        var array: [RepoModel]?
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "gitHubData", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)

      // when
        if let safeData = data {
            array = sut.parseJSON(safeData)
        }

      // then
        XCTAssertEqual(array?.count, 3)
    }

    func testParsingFails() {
        // given
        var array: [RepoModel]?
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "gitHubErrorData", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)

        // when
        if let safeData = data {
            array = sut.parseJSON(safeData)
        }

        // then
        XCTAssertNil(array)
    }


    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

}
