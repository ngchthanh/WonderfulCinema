//
//  WonderfulCinemaTests.swift
//  WonderfulCinemaTests
//
//  Created by Nguyen Chi Thanh on 23/03/2021.
//

import XCTest
@testable import WonderfulCinema
import Combine

class WonderfulCinemaTests: XCTestCase {
    
    var bag = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testTrendingAPI() throws {
        let exp = expectation(description: "🍏🍏🍏")
        let movieAPI = MovieAPI()
        movieAPI.getTrending(page: 1).sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertThrowsError(error.errorDescription)
            case .finished: break
            }
        } receiveValue: { (result) in
            XCTAssertNotNil(result.results, "data is nil ⚠️⚠️⚠️⚠️⚠️⚠️")
            if let _ = result.results {
                exp.fulfill()
            }
        }.store(in: &bag)
        wait(for: [exp], timeout: 5)
    }
    
    func testPopularAPI() throws {
        let exp = expectation(description: "🍏🍏🍏")
        let movieAPI = MovieAPI()
        movieAPI.getPopular(page: 1).sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertThrowsError(error.errorDescription)
            case .finished: break
            }
        } receiveValue: { (result) in
            XCTAssertNotNil(result.results, "data is nil ⚠️⚠️⚠️⚠️⚠️⚠️")
            if let _ = result.results {
                exp.fulfill()
            }
        }.store(in: &bag)
        wait(for: [exp], timeout: 5)
    }
    
    func testTopRatedAPI() throws {
        let exp = expectation(description: "🍏🍏🍏")
        let movieAPI = MovieAPI()
        movieAPI.getTopRated(page: 1).sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertThrowsError(error.errorDescription)
            case .finished: break
            }
        } receiveValue: { (result) in
            XCTAssertNotNil(result.results, "data is nil ⚠️⚠️⚠️⚠️⚠️⚠️")
            if let _ = result.results {
                exp.fulfill()
            }
        }.store(in: &bag)
        wait(for: [exp], timeout: 5)
    }
    
    func testUpcomingAPI() throws {
        let exp = expectation(description: "🍏🍏🍏")
        let movieAPI = MovieAPI()
        movieAPI.getUpcoming(page: 1).sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertThrowsError(error.errorDescription)
            case .finished: break
            }
        } receiveValue: { (result) in
            XCTAssertNotNil(result.results, "data is nil ⚠️⚠️⚠️⚠️⚠️⚠️")
            if let _ = result.results {
                exp.fulfill()
            }
        }.store(in: &bag)
        wait(for: [exp], timeout: 5)
    }
    
    func testGenresAPI() throws {
        let exp = expectation(description: "🍏🍏🍏")
        let movieAPI = MovieAPI()
        movieAPI.getGenres().sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertThrowsError(error.errorDescription)
            case .finished: break
            }
        } receiveValue: { (result) in
            print(result.genres.count)
            XCTAssertFalse(result.genres.count == 0, "data is empty ⚠️⚠️⚠️⚠️⚠️⚠️")
            if result.genres.count > 0 {
                exp.fulfill()
            }
        }.store(in: &bag)
        wait(for: [exp], timeout: 5)
    }
    
    func testMovieDetailsAPI() throws {
        let exp = expectation(description: "🍏🍏🍏")
        let movieAPI = MovieAPI()
        movieAPI.getDetails(movieID: 123).sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertThrowsError(error.errorDescription)
            case .finished: break
            }
        } receiveValue: { (result) in
            exp.fulfill()
        }.store(in: &bag)
        wait(for: [exp], timeout: 5)
    }
    
    func testMovieCreditsAPI() throws {
        let exp = expectation(description: "🍏🍏🍏")
        let movieAPI = MovieAPI()
        movieAPI.getCredits(movieID: 123).sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertThrowsError(error.errorDescription)
            case .finished: break
            }
        } receiveValue: { (result) in
            exp.fulfill()
        }.store(in: &bag)
        wait(for: [exp], timeout: 5)
    }
    
    func testVideosAPI() throws {
        let exp = expectation(description: "🍏🍏🍏")
        let movieAPI = MovieAPI()
        movieAPI.getVideos(of: 123).sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertThrowsError(error.errorDescription)
            case .finished: break
            }
        } receiveValue: { (result) in
            exp.fulfill()
        }.store(in: &bag)
        wait(for: [exp], timeout: 5)
    }
    
    func testReviewAPI() throws {
        let exp = expectation(description: "🍏🍏🍏")
        let movieAPI = MovieAPI()
        movieAPI.getReviews(of: 123, page: 1).sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertThrowsError(error.errorDescription)
            case .finished: break
            }
        } receiveValue: { (result) in
            exp.fulfill()
        }.store(in: &bag)
        wait(for: [exp], timeout: 5)
    }
    
    func testRecommendationsAPI() throws {
        let exp = expectation(description: "🍏🍏🍏")
        let movieAPI = MovieAPI()
        movieAPI.getRecommendations(of: 123, page: 1).sink { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssertThrowsError(error.errorDescription)
            case .finished: break
            }
        } receiveValue: { (result) in
            exp.fulfill()
        }.store(in: &bag)
        wait(for: [exp], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            Helper.dateFormatter.string(from: Date())
            Helper.releaseDateFormatter.date(from: "2020-03-15")
        }
    }

}
