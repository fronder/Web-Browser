//
//  HistoryCellController.swift
//  TTT
//
//  Created by Hasan on 16/05/23.
//

import UIKit

final class HistoryCellController {
    private(set) var model: LocalFeedModel
    private var cell: HistoryCell?
    
    init(model: LocalFeedModel) {
        self.model = model
    }
    
    func view(in tableView: UITableView) -> UITableViewCell {
        cell = tableView.dequeueReusableCell()
        cell?.textLabel?.text = model.urlString
        return cell!
    }
}
