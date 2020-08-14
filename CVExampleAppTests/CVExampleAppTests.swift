//
//  CVExampleAppTests.swift
//  CVExampleAppTests
//
//  Created by Denis Sushkov on 17.07.2020.
//  Copyright © 2020 Denis Sushkov. All rights reserved.
//

import XCTest
@testable import CVExampleApp

class CVExampleAppTests: XCTestCase {

    var sut: URLSession!

    override func setUpWithError() throws {
        super.setUp()
        sut = URLSession(configuration: .default)
    }

    func testToGitHubCompletes() {
    //    given
        let url = URL(string: "https://api.github.com/repositories?since=\(Int.random(in: 1...99999999))")
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?

    //    when
        let dataTask = sut.dataTask(with: url!) {data, response, error in
          statusCode = (response as? HTTPURLResponse)?.statusCode
          responseError = error
          promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)

    //    then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
      }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
}
