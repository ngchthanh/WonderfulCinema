//
//  MovieListDatasourceTest.swift
//  WonderfulCinemaTests
//
//  Created by Nguyen Chi Thanh on 28/03/2021.
//

import XCTest
@testable import WonderfulCinema
import Combine

class MovieListDatasourceTest: XCTestCase {
    private var bag = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPIs() throws {
        let popularListDatasource = MovieListDatasource(datasourceType: .popular, movieAPI: MovieAPI())
        let trendingListDatasource = MovieListDatasource(datasourceType: .trending, movieAPI: MovieAPI())
        let topRatedListDatasource = MovieListDatasource(datasourceType: .topRated, movieAPI: MovieAPI())
        let upcomingListDatasource = MovieListDatasource(datasourceType: .upcoming, movieAPI: MovieAPI())
        let recommandationsListDatasource = MovieListDatasource(datasourceType: .recommendations(movieID: 123), movieAPI: MovieAPI())
        
        let datasources = [popularListDatasource, trendingListDatasource, topRatedListDatasource, upcomingListDatasource, recommandationsListDatasource]
        for datasource in datasources {
            let exp = expectation(description: "🍏🍏🍏 \(datasource.datasourceType.description)")
            let errorExp = expectation(description: "Error \(datasource.datasourceType.description)")
            datasource.page = 1
            datasource.$movies.dropFirst().sink(receiveValue: { movies in
                XCTAssertFalse(movies.isEmpty, "movies is empty ⚠️⚠️⚠️⚠️⚠️")
                if !movies.isEmpty {
                    exp.fulfill()
                }
            }).store(in: &bag)
            datasource.$error.sink { error in
                XCTAssertNil(error, "Error ⚠️⚠️⚠️⚠️⚠️")
                if error == nil {
                    errorExp.fulfill()
                }
            }.store(in: &bag)
            wait(for: [exp, errorExp], timeout: 10)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
