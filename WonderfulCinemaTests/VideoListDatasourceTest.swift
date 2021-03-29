//
//  VideoListDatasourceTest.swift
//  WonderfulCinemaTests
//
//  Created by Nguyen Chi Thanh on 28/03/2021.
//

import XCTest
@testable import WonderfulCinema
import Combine

class VideoListDatasourceTest: XCTestCase {
    private var bag = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAPI() {
        let datasource = VideoListDatasource(movieID: 123, movieAPI: MovieAPI())
        let exp = expectation(description: "🍏 ")
        let errExp = expectation(description: "⚠️ Error")
        datasource.$videos.dropFirst().sink { videos in
            XCTAssertFalse(videos.isEmpty, "videos is empty")
            if !videos.isEmpty {
                exp.fulfill()
            }
        }.store(in: &bag)
        datasource.$error.sink { error in
            XCTAssertNil(error, "Have an error")
            if error == nil {
                errExp.fulfill()
            }
        }.store(in: &bag)
        wait(for: [exp, errExp], timeout: 10)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
