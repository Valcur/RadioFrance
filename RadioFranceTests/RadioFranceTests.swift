//
//  RadioFranceTests.swift
//  RadioFranceTests
//
//  Created by Loic D on 17/11/2022.
//

import XCTest
@testable import RadioFrance

final class RadioFranceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadRadioStationList() throws {
        let radioStationVM = RadioStationListViewModel()
        let expectation = expectation(description: "Waiting for Radio Stations List to load")
        
        
        radioStationVM.loadRadioStationsList {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(radioStationVM.stations.count == 7)   // Should have all 7 radio stations
    }
    
    func testLoadShowsFromStation() throws {
        let radioStationVM = RadioStationListViewModel()
        let expectation = expectation(description: "Waiting for Shows to load")
        var showsTest: [Show] = []
        
        radioStationVM.loadShowsFromStation("FIP", first: 10) { shows in
            showsTest = shows
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(showsTest.count > 0)  // Should retrieve at least 1 show
    }
    
    func testLoadShowsFromStationAfter() throws {
        let radioStationVM = RadioStationListViewModel()
        let expectation = expectation(description: "Waiting for Shows to load")
        var showsTest: [Show] = []
        
        radioStationVM.loadShowsFromStation("FIP", first: 10, after: "YzdkNTNlYTUtZTcxYi00OTJlLWIyZmYtNDc2ZDcwNDllOTdi") { shows in
            showsTest = shows
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(showsTest.count > 0)  // Should retrieve at least 1 show
    }
}
