//
//  HistoryFeedLoader.swift
//  TTT
//
//  Created by Hasan on 16/05/23.
//

import Foundation

class HistoryFeedLoader: HistoryLoader {
    let feedStore: FeedStore
    
    init(feedStore: FeedStore) {
        self.feedStore = feedStore
    }
    
    func load(completion: @escaping (HistoryLoader.Result) -> Void) {
        feedStore.retrieve { result in
            switch result {
            case let .success(items):
                completion(.success(items.map { LocalFeedModel(urlString: $0) }))
            case .failure:
                break
            }
        }
    }
}
