//
//  MainQueueDispatchDecorator.swift
//  TTT
//
//  Created by Hasan on 16/05/23.
//

import Foundation

final class MainQueueDispatchDecorator<T> {
    private let decoratee: T

    init(decoratee: T) {
        self.decoratee = decoratee
    }

    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }

        completion()
    }
}

extension MainQueueDispatchDecorator: FeedLoader where T == FeedLoader {
    func load(url: URL?, completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load(url: url) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
