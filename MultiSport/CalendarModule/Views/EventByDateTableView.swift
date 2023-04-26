//
//  EventByDateTableView.swift
//  MultiSport
//
//  Created by Витя Рябко on 27/04/23.
//

import Foundation

import UIKit

class EventByDateTableView: UITableView {
    
    // MARK: - UI Components
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        register(EventByDateTableViewCell.self, forCellReuseIdentifier: EventByDateTableViewCell.identifier)
        
        config()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Config
    private func config() {
        self.backgroundColor = .clear
    }
    
    // MARK: - SetDelegate
    private func setDelegate() {
        self.dataSource = self
        self.delegate = self
    }
}

// MARK: -  UITableViewDataSource, UITableViewDelegate
extension EventByDateTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        13
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventByDateTableViewCell.identifier, for: indexPath)
    
        return cell
    }
    
    
}
