//
//  FeedPresenter.swift
//  TTT
//
//  Created by Hasan on 16/05/23.
//

import Foundation

protocol FeedView {
    func display(_ url: URL)
}

struct FeedFailureViewModel {
    let title: String
    let message: String
}

protocol FeedFailureView {
    func display(_ failureViewModel: FeedFailureViewModel)
}

final class FeedPresenter {
    private let feedView: FeedView
    private let failureView: FeedFailureView
    
    init(feedView: FeedView, failureView: FeedFailureView) {
        self.feedView = feedView
        self.failureView = failureView
    }
    
    func didFinishLoadingFeed(with url: URL) {
        feedView.display(url)
    }
    
    func didFinishLoadingFeed(with error: Error) {
        failureView.display(FeedFailureViewModel(title: "Warning", message: "Wrong URL"))
    }
}
