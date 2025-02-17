//
//  Model.swift
//  SwiftUI Navigation and Other Controls
//
//  Created by Emmanuel Makoye on 2/17/25.
//

import Foundation

struct ContactModel {
    static private func fileURL() -> URL? {
        let manager = FileManager.default
        let documentsDirectory = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentsDirectory?.appendingPathComponent("contacts.json")
        
    }
    
    static public func save(_ contacts:[Contact]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(contacts)
            if let fileURL = fileURL() {
                try data.write(to: fileURL, options: [.completeFileProtection, .atomic])
            }
        }
        catch {
            print("Unable to save data \(error)")
        }
        
    }
    
    static public func load() -> [Contact] {
        let decoder = JSONDecoder()
        if let fileURL = fileURL(),
           let data = try? Data(contentsOf: fileURL),
           let loadedContacts = try? decoder.decode([Contact].self, from: data){
            return loadedContacts
        }
        return [Contact]()
    }
}
