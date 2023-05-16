//
//  LoaderSpy.swift
//  TTTTests
//
//  Created by Hasan on 16/05/23.
//

import Foundation

class LoaderSpy: FeedLoader {
    
    private var feedRequests = [(FeedLoader.Result) -> Void]()
    
    var loadFeedCallCount: Int {
        return feedRequests.count
    }
    
    func load(url: URL?, completion: @escaping (FeedLoader.Result) -> Void) {
        feedRequests.append(completion)
    }
    
    func completeFeedLoadingSuccessfully(at index: Int = 0) {
        let url = URL(string: "http://googl.com")!
        feedRequests[index](.success(url))
    }
    
    func completeFeedLoadingWithError(at index: Int = 0) {
        let error = NSError(domain: "an error", code: 0)
        feedRequests[index](.failure(error))
    }
}
