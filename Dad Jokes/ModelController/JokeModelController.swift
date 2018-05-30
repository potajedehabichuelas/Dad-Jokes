//
//  JokeModelController.swift
//  Dad Jokes
//
//  Created by Daniel Bolivar herrera on 30/05/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

class JokeModelController {

    static let sharedInstance = JokeModelController()
    
    private var jokes: [Joke] = [] {
        didSet {
            self.saveJokes()
        }
    }
    
    private static let jokesRefillThreshold = 15
    
    var jokesCount: Int {
        return self.jokes.count
    }
    
    func checkJokesStorageAmount() {
        //Checks the amount of jokes stored and add some if required
        if self.jokes.count < JokeModelController.jokesRefillThreshold {
            self.addNewJokes { () in }
        }
    }
    
    func retrieveContacts(completion: @escaping () -> Void) {
        //Retrieve Jokes
        self.jokes = DJStorage.retrieveJokes()
        //If we retrieved less than X jokes, we request a few more so we can be funny on time
        if self.jokes.count <= JokeModelController.jokesRefillThreshold {
            self.addNewJokes { () in
                completion()
            }
        } else {
            completion()
        }
    }
    
    private func addNewJokes(completion: @escaping () -> Void) {
        var jokesReceived = 0
        //This ideally would be achieved by requesting a batch of jokes, but server doesn't support pagination ?
        for _ in 0..<JokeModelController.jokesRefillThreshold {
            JokeRequestManager.sharedInstance.queryDadJoke(completion: { joke in
                guard let id = joke.id, let jokeText = joke.joke, let link = joke.permalink else { return }
                self.createJoke(id: id, text: jokeText, permaLink: link)
                jokesReceived += 1
                if jokesReceived == JokeModelController.jokesRefillThreshold {
                    completion()
                }
            })
        }
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
