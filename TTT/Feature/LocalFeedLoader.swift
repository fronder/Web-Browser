//
//  LocalFeedLoader.swift
//  TTT
//
//  Created by Hasan on 16/05/23.
//

import Foundation

public final class LocalFeedLoader {
    private let store: FeedStore
    
    public init(store: FeedStore) {
        self.store = store
    }
}

extension LocalFeedLoader {
    public typealias SaveResult = Result<Void, Error>
    
    public func save(_ feed: String, completion: @escaping (SaveResult) -> Void) {
        store.insert(feed) { [weak self] insertionResult in
            guard self != nil else { return }
            
            completion(insertionResult)
        }
    }
}

extension LocalFeedLoader: HistoryLoader {
    public typealias LoadResult = HistoryLoader.Result
    
    public func load(completion: @escaping (LoadResult) -> Void) {
        store.retrieve { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success(feed):
                completion(.success(feed))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

