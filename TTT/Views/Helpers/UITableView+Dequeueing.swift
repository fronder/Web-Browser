//
//  UITableView+Dequeueing.swift
//  TTT
//
//  Created by Hasan on 16/05/23.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
