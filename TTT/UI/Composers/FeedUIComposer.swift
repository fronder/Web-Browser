//
//  FeedUIComposer.swift
//  TTT
//
//  Created by Hasan on 16/05/23.
//

import UIKit

public final class FeedUIComposer {
    private init() {}
    
    public static func feedComposedWith(feedLoader: FeedLoader, feedStore: FeedStore) -> FeedViewController {
        let presentationAdapter = FeedLoaderPresentationAdapter(
            feedLoader: MainQueueDispatchDecorator(decoratee: feedLoader))

        let feedController = makeFeedViewController(delegate: presentationAdapter, feedStore: feedStore)
        feedController.cellSelectionDelegate = presentationAdapter
        
        presentationAdapter.presenter = FeedPresenter(
            feedView: WeakRefVirtualProxy(feedController),
            failureView: WeakRefVirtualProxy(feedController))
        
        return feedController
    }
    
    private static func makeFeedViewController(delegate: FeedViewControllerDelegate, feedStore: FeedStore) -> FeedViewController {
        let bundle = Bundle(for: FeedViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let feedController = storyboard.instantiateViewController(identifier: String(describing: FeedViewController.self), creator: { coder in
            return FeedViewController(coder: coder, delegate: delegate, feedStore: feedStore)
        })
        
        return feedController
    }
}
