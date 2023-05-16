//
//  WeakRefVirtualProxy.swift
//  TTT
//
//  Created by Hasan on 16/05/23.
//

import UIKit

final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?

    init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: FeedView where T: FeedView {
    func display(_ url: URL) {
        object?.display(url)
    }
}

extension WeakRefVirtualProxy: FeedFailureView where T: FeedFailureView {
    func display(_ failureViewModel: FeedFailureViewModel) {
        object?.display(failureViewModel)
    }
}

extension WeakRefVirtualProxy: HistoryView where T: HistoryView {
    func display(_ model: [String]) {
        object?.display(model)
    }
}
