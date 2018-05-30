//
//  JokeModelControllerTests.swift
//  Dad JokesTests
//
//  Created by Daniel Bolivar herrera on 30/05/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import XCTest

class JokeModelControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJokesCount() {
        JokeModelController.sharedInstance.removeAllJokes()
        
        XCTAssertEqual(JokeModelController.sharedInstance.jokesCount, 0)
        
        JokeModelController.sharedInstance.createJoke(id: "3", text: "something funny", permaLink: "www.fun.com")
        
        XCTAssertEqual(JokeModelController.sharedInstance.jokesCount, 1)
        
        JokeModelController.sharedInstance.createJoke(id: "4", text: "something more funny", permaLink: "www.morefun.com")
        
        XCTAssertEqual(JokeModelController.sharedInstance.jokesCount, 2)
        
    }
    
    func testJokesAtIndex() {
        JokeModelController.sharedInstance.removeAllJokes()
    
        let id = "3"
        let jokeText = "something funny"
        let jokeSite = "www.fun.com"
    
        JokeModelController.sharedInstance.createJoke(id: "3", text: "something funny", permaLink: jokeSite)
        JokeModelController.sharedInstance.createJoke(id: "4", text: "something more funny", permaLink: "www.morefun.com")
        
        let joke = JokeModelController.sharedInstance.joke(at: 0)
        
        XCTAssertEqual(joke.id, id)
        XCTAssertEqual(joke.joke, jokeText)
        XCTAssertEqual(joke.permalink, jokeSite)
    }
    
    func testAddJoke() {
        
        let id = "3"
        let jokeText = "something funny"
        let jokeSite = "www.fun.com"
        
        JokeModelController.sharedInstance.removeAllJokes()
        
        JokeModelController.sharedInstance.createJoke(id: id, text: jokeText, permaLink: jokeSite)
        XCTAssertEqual(JokeModelController.sharedInstance.jokesCount, 1)
        
        let firstJoke = JokeModelController.sharedInstance.joke(at: 0)
        
        XCTAssertEqual(firstJoke.id, id)
        XCTAssertEqual(firstJoke.joke, jokeText)
        XCTAssertEqual(firstJoke.permalink, jokeSite)
    }
    
    func testRemoveJoke() {
        JokeModelController.sharedInstance.removeAllJokes()
        
        let id = "3"
        let jokeText = "something funny"
        let jokeSite = "www.fun.com"

        JokeModelController.sharedInstance.createJoke(id: "2", text: "something funny", permaLink: "www.ha.com")
        JokeModelController.sharedInstance.createJoke(id: id, text: jokeText, permaLink: jokeSite)
        JokeModelController.sharedInstance.removeJoke(at: 0)
        XCTAssertEqual(JokeModelController.sharedInstance.jokesCount, 1)
        
        let firstJoke = JokeModelController.sharedInstance.joke(at: 0)
        
        XCTAssertEqual(firstJoke.id, id)
        XCTAssertEqual(firstJoke.joke, jokeText)
        XCTAssertEqual(firstJoke.permalink, jokeSite)
    }
    
    func testRemoveAllJokes() {
        JokeModelController.sharedInstance.removeAllJokes()

        if JokeModelController.sharedInstance.jokesCount == 0 {
            XCTAssert(true)
        } else {
            XCTFail()
        }

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
