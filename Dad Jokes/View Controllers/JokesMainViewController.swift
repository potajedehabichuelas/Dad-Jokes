//
//  ViewController.swift
//  Dad Jokes
//
//  Created by Daniel Bolivar herrera on 29/05/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class JokesMainViewController: UIViewController {

    @IBOutlet weak var jokeText: UITextView!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    @IBOutlet weak var activityIndicatorFrame: UIView!
    
    var jokesDelegate: JokeControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startActivityIndicator()
        self.jokesDelegate?.retrieveJokes(completion: { [weak self] in
            self?.setNewJoke()
            self?.stopActivityIndicator()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNewJoke() {
        guard let jokesDelegate = self.jokesDelegate else { return }
        
        DispatchQueue.main.async {
            if jokesDelegate.jokesCount() > 0 {
                self.jokeText.text = jokesDelegate.joke(at: 0).joke
                //Remove used joke
                jokesDelegate.removeJoke(at: 0)
                //Check if we might need to refill the cold jokes storage!
                jokesDelegate.checkJokesStorageAmount()
            }
        }
    }
    
    func startActivityIndicator() {
        self.activityIndicatorFrame.isHidden = false
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            self.activityIndicator.stopAnimating()
            self.activityIndicatorFrame.isHidden = true
        }
    }

    @IBAction func crackJokeButton(_ sender: Any) {
        self.setNewJoke()
    }
    
    // Mark : JokeModelController Protocol
}

