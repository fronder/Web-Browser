//
//  HistoryUIComposer.swift
//  TTT
//
//  Created by Hasan on 16/05/23.
//

import UIKit

class HistoryFeedViewAdapter: HistoryView {
    private weak var controller: HistoryViewController?
    
    init(controller: HistoryViewController) {
        self.controller = controller
    }
    
    func display(_ model: [String]) {
        controller?.tableModel = model.map { feed in
            HistoryCellController(model: LocalFeedModel(urlString: feed))
        }
    }
}

public final class HistoryUIComposer {
    private init() {}
    
    public static func composedWith(feedLoader: HistoryLoader, cellSelectionDelegate: HistoryCellSelectionDelegate?) -> HistoryViewController {
        let presentationAdapter = HistoryLoaderPresentationAdapter(
            historyLoader: feedLoader)
        
        let controller = makeHistoryViewController(delegate: presentationAdapter, cellSelectionDelegate: cellSelectionDelegate)
        
        presentationAdapter.presenter = HistoryPresenter(
            historyView: HistoryFeedViewAdapter(controller: controller))
        return controller
    }
    
    private static func makeHistoryViewController(delegate: HistoryViewControllerDelegate, cellSelectionDelegate: HistoryCellSelectionDelegate?) -> HistoryViewController {
        let bundle = Bundle(for: HistoryCellController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let controller = storyboard.instantiateViewController(identifier: String(describing: HistoryViewController.self), creator: { coder in
            return HistoryViewController(
                coder: coder,
                delegate: delegate,
                cellSelectionDelegate: cellSelectionDelegate)
        })
        
        return controller
    }
}
