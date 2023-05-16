//
//  WebFeedLoader.swift
//  TTT
//
//  Created by Hasan on 16/05/23.
//

import Foundation

class WebFeedLoader: FeedLoader {
    func load(url: URL?, completion: @escaping (FeedLoader.Result) -> Void) {
        completion(.success(url!))
    }
}
