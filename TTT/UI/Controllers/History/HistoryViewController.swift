//
//  HistoryViewController.swift
//  TTT
//
//  Created by Hasan on 16/05/23.
//

import UIKit

public protocol HistoryCellSelectionDelegate {
    func didSelect(model: LocalFeedModel)
}

protocol HistoryViewControllerDelegate {
    func requestFeed()
}

public class HistoryViewController: UITableViewController {
    
    var tableModel = [HistoryCellController]() {
        didSet { tableView.reloadData() }
    }
    
    var delegate: HistoryViewControllerDelegate?
    var cellSelectionDelegate: HistoryCellSelectionDelegate?
    
    init?(coder: NSCoder, delegate: HistoryViewControllerDelegate, cellSelectionDelegate: HistoryCellSelectionDelegate?) {
        self.delegate = delegate
        self.cellSelectionDelegate = cellSelectionDelegate
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate?.requestFeed()
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
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellController = tableModel[indexPath.row]
        cellSelectionDelegate?.didSelect(model: cellController.model)
        
        dismiss(animated: true)
    }
}
