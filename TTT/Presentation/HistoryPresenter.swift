//
//  HistoryPresenter.swift
//  TTT
//
//  Created by Hasan on 16/05/23.
//

import Foundation

protocol HistoryView {
    func display(_ model: [String])
}

final class HistoryPresenter {
    private let historyView: HistoryView
    
    init(historyView: HistoryView) {
        self.historyView = historyView
    }
    
    func didFinishLoadingFeed(with model: [String]) {
        historyView.display(model)
    }
}
