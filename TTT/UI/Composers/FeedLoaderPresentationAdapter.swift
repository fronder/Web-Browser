//
//  FeedLoaderPresentationAdapter.swift
//  TTT
//
//  Created by Hasan on 16/05/23.
//

import Foundation

final class FeedLoaderPresentationAdapter: FeedViewControllerDelegate, HistoryCellSelectionDelegate {
    private let feedLoader: FeedLoader
    var presenter: FeedPresenter?

    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }

    func didRequestFeed(with url: URL) {
        feedLoader.load(url: url) { [weak self] result in
            switch result {
            case let .success(feed):
                self?.presenter?.didFinishLoadingFeed(with: feed)

            case let .failure(error):
                self?.presenter?.didFinishLoadingFeed(with: error)
            }
        }
    }
    
    func didSelect(model: LocalFeedModel) {
        if let url = URL(string: model.urlString) {
            presenter?.didFinishLoadingFeed(with: url)
        }
    }
}
