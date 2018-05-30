//
//  DJStorage.swift
//  Dad Jokes
//
//  Created by Daniel Bolivar herrera on 29/05/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import UIKit

struct storageConstants {
    static let jokesFile = "jokes"
}

class DJStorage: NSObject {
    
    static let jokesFilePath = DJStorage.getDocumentsDirectory().appendingPathComponent(storageConstants.jokesFile)
    
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func saveJokes(jokes: [Joke]) {
        
        do {
            let data = try PropertyListEncoder().encode(jokes)
            let success = NSKeyedArchiver.archiveRootObject(data, toFile: jokesFilePath.path)
            print(success ? "Successful save" : "Save Failed")
        } catch {
            print("Save Failed")
        }
    }
    
    class func retrieveJokes() -> [Joke] {
        
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: jokesFilePath.path) as? Data else { return [] }
        
        do {
            let jokes = try PropertyListDecoder().decode([Joke].self, from: data)
            return jokes
        } catch {
            print("Retrieve Failed")
            return []
        }
    }
}
