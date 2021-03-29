//
//  GenreListDatasourceTest.swift
//  WonderfulCinemaTests
//
//  Created by Nguyen Chi Thanh on 28/03/2021.
//

import XCTest
@testable import WonderfulCinema
import Combine

class GenreListDatasourceTest: XCTestCase {
    private var bag = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPI() throws {
        let datasource = GenreListDatasource(movieAPI: MovieAPI())
        let exp = expectation(description: "🍏🍏🍏 ")
        let errorExp = expectation(description: "Error")
        datasource.$genres.dropFirst().sink(receiveValue: { genres in
            XCTAssertFalse(genres.isEmpty, "movies is empty ⚠️⚠️⚠️⚠️⚠️")
            if !genres.isEmpty {
                exp.fulfill()
            }
        }).store(in: &bag)
        datasource.$error.sink { error in
            XCTAssertNil(error, "Have an error ⚠️⚠️⚠️⚠️⚠️")
            if error == nil {
                errorExp.fulfill()
            }
        }.store(in: &bag)
        wait(for: [exp, errorExp], timeout: 10)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
