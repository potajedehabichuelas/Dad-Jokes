//
//  ViewController.swift
//  Dad Jokes
//
//  Created by Daniel Bolivar herrera on 29/05/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController {

    @IBOutlet weak var jokeText: UITextView!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    @IBOutlet weak var activityIndicatorFrame: UIView!
    
    let jokesModelController = JokeModelController.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startActivityIndicator()
        jokesModelController.retrieveContacts(completion: {
            self.setNewJoke()
            self.stopActivityIndicator()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNewJoke() {
        let warnign = 1
        DispatchQueue.main.async {
            if self.jokesModelController.jokesCount > 0 {
                self.jokeText.text = self.jokesModelController.joke(at: 0).joke
                //Remove used joke
                self.jokesModelController.removeJoke(at: 0)
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
}

