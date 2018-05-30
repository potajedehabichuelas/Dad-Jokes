//
//  JokeRequestManager.swift
//  Dad Jokes
//
//  Created by Daniel Bolivar herrera on 30/05/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import Apollo

class JokeRequestManager {
    
    static let sharedInstance = JokeRequestManager()

    // Fetch a Joke through GraphQL
    func queryDadJoke(completion: @escaping (DadJokeQuery.Data.Joke) -> Void) {
        
        let dadJokeQuery = DadJokeQuery()

        apollo.fetch(query: dadJokeQuery, cachePolicy: .fetchIgnoringCacheData, queue: .global(), resultHandler: { result, error in
            guard let joke = result?.data?.joke else { return }
            completion(joke)
        })        
    }
}
