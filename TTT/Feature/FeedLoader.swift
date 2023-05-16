//
//  FeedLoader.swift
//  TTT
//
//  Created by Hasan on 15/05/23.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<URL, Error>
    
    func load(url: URL?, completion: @escaping (Result) -> Void)
}
