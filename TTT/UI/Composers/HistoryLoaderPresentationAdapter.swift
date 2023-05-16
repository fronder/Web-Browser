//
//  HistoryLoaderPresentationAdapter.swift
//  TTT
//
//  Created by Hasan on 16/05/23.
//

import Foundation

final class HistoryLoaderPresentationAdapter: HistoryViewControllerDelegate {
    private let historyLoader: HistoryLoader
    var presenter: HistoryPresenter?
    
    init(historyLoader: HistoryLoader) {
        self.historyLoader = historyLoader
    }
    
    func requestFeed() {
        historyLoader.load { [weak self] result in
            switch result {
            case let .success(localFeed):
                self?.presenter?.didFinishLoadingFeed(with: localFeed)
            case .failure:
                break
            }
        }
    }
}
