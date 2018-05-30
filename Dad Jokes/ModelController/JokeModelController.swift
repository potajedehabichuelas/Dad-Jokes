//
//  JokeModelController.swift
//  Dad Jokes
//
//  Created by Daniel Bolivar herrera on 30/05/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

class JokeModelController {

    static let sharedInstance = JokeModelController()
    
    private var jokes: [Joke] = DJStorage.retrieveJokes()
    
    var jokesCount: Int {
        return self.jokes.count
    }
    
    func createJoke(id: String, text: String, permaLink: String) {
        let newJoke = Joke(id: id, joke: text, permalink: permaLink)
        self.jokes.append(newJoke)
    }
    
    func joke(at index: Int) -> Joke {
        return self.jokes[index]
    }
    
    func removeJoke(at index: Int) {
        self.jokes.remove(at: index)
    }
    
    func removeAllJokes() {
        self.jokes.removeAll()
    }
    
    func saveJokes() {
        DJStorage.saveJokes(jokes: self.jokes)
    }
}
