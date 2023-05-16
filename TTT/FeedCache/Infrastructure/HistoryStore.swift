//
//  HistoryStore.swift
//  TTT
//
//  Created by Hasan on 16/05/23.
//

import Foundation

class HistoryStore: FeedStore {
    func insert(_ feed: String, completion: @escaping InsertionCompletion) {
        if var items: [String] = UserDefaults.standard.value(forKey: "feed") as? [String] {
            items.append(feed)
            UserDefaults.standard.set(items, forKey: "feed")
        } else {
            UserDefaults.standard.set([feed], forKey: "feed")
        }
        completion(.success(()))
    }
    
    func retrieve(completion: @escaping RetrievalCompletion) {
        guard let items: [String] = UserDefaults.standard.object(forKey: "feed") as? [String] else {
            return completion(.success([]))
        }
        
        completion(.success(items))
    }
}
