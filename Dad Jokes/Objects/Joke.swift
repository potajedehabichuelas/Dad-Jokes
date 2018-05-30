//
//  Joke.swift
//  Dad Jokes
//
//  Created by Daniel Bolivar herrera on 29/05/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import UIKit
import Apollo

struct Joke: Codable {
    var id: String // GraphQLID is the original type but it doesn't conform to codable :P
    var joke: String
    var permalink: String
}
