//
//  JokeModelController.swift
//  Dad Jokes
//
//  Created by Daniel Bolivar herrera on 30/05/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

protocol JokeControllerProtocol: class {
    func checkJokesStorageAmount()
    func jokesCount() -> Int
    func retrieveJokes(completion: @escaping () -> Void)
    func createJoke(id: String, text: String, permaLink: String)
    func joke(at index: Int) -> Joke
    func removeJoke(at index: Int)
    func removeAllJokes()
    func saveJokes()
}

class JokeModelController: JokeControllerProtocol {
    
    private var jokes: [Joke] = [] {
        didSet {
            self.saveJokes()
        }
    }
    
    private static let jokesRefillThreshold = 50
    
    func jokesCount() -> Int {
        return self.jokes.count
    }
    
    func checkJokesStorageAmount() {
        //Checks the amount of jokes stored and add some if required
        if self.jokes.count < JokeModelController.jokesRefillThreshold {
            self.addNewJokes(amount: JokeModelController.jokesRefillThreshold, completion: { () in })
        }
    }
    
    func retrieveJokes(completion: @escaping () -> Void) {
        //Retrieve Jokes
        self.jokes = DJStorage.retrieveJokes()
        //If we retrieved less than X jokes, we request a few more so we can be funny on time
        if self.jokes.count <= JokeModelController.jokesRefillThreshold {
            self.addNewJokes(amount: 1, completion: {
                completion()
            })
        } else {
            completion()
        }
    }
    
    private func addNewJokes(amount: Int ,completion: @escaping () -> Void) {
        var jokesReceived = 0
        //This ideally would be achieved by requesting a batch of jokes, but server doesn't support pagination ?
        for _ in 0..<amount {
            JokeRequestManager.sharedInstance.queryDadJoke(completion: { [weak self] joke in
                if let jk = joke, let id = jk.id, let jokeText = jk.joke, let link = jk.permalink {
                    self?.createJoke(id: id, text: jokeText, permaLink: link)
                }
                jokesReceived += 1
                if jokesReceived == amount {
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
