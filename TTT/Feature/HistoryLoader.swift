//
//  HistoryLoader.swift
//  TTT
//
//  Created by Hasan on 16/05/23.
//

import Foundation

public protocol HistoryLoader {
    typealias Result = Swift.Result<[String], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
