//
//  HistoryViewController.swift
//  TTT
//
//  Created by Hasan on 16/05/23.
//

import UIKit

protocol HistoryViewControllerDelegate {
}

public class HistoryViewController: UITableViewController {
    private var tableModel = [HistoryCellController]() {
        didSet { tableView.reloadData() }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableModel = [
            HistoryCellController(),
            HistoryCellController(),
            HistoryCellController(),
            HistoryCellController(),
            HistoryCellController()
        ]
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController(forRowAt: indexPath).view(in: tableView)
    }

    private func cellController(forRowAt indexPath: IndexPath) -> HistoryCellController {
        return tableModel[indexPath.row]
    }
}
