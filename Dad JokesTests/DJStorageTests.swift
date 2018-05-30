//
//  DJStorageTests.swift
//  Dad JokesTests
//
//  Created by Daniel Bolivar herrera on 30/05/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import XCTest

class DJStorageTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStorageRetrieval() {
        
        let newJoke = Joke(id: "1", joke: "test joke", permalink: "www.test.joke")
        DJStorage.saveJokes(jokes: [newJoke])
        let jokes = DJStorage.retrieveJokes()
        guard let firstJoke = jokes.first else { XCTFail(); return }
        
        XCTAssertEqual(jokes.count, 1)
        XCTAssertEqual(firstJoke.id, newJoke.id)
        XCTAssertEqual(firstJoke.joke, newJoke.joke)
        XCTAssertEqual(firstJoke.permalink, newJoke.permalink)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
