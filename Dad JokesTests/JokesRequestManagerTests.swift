//
//  JokesRequestManagerTests.swift
//  Dad JokesTests
//
//  Created by Daniel Bolivar herrera on 30/05/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import XCTest
import Apollo

let graphQLEndpoint = "https://icanhazdadjoke.com/graphql"
let apollo:ApolloClient = ApolloClient(url: URL(string: graphQLEndpoint)!)

class JokesRequestManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEventFeedRequest() {
        
        let ex = expectation(description: "Expecting a Joke GraphQL object")
        
        JokeRequestManager.sharedInstance.queryDadJoke(completion: { joke in
            
            guard let jk = joke else {  XCTFail("Return object is nil"); return}
    
            XCTAssertNotNil(jk.id)
            XCTAssertNotNil(jk.joke)
            XCTAssertNotNil(jk.permalink)
            
            ex.fulfill()
        })
        
        waitForExpectations(timeout: 15) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
