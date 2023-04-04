//
//  MainTableView.swift
//  MultiSport
//
//  Created by Витя Рябко on 04/04/23.
//

import UIKit

class MainTableView: UITableView {
    
    private let mainTableTypeItems = MainTablesTypeItem.allCases
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        
        config()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        self.backgroundColor = .clear
        self.bounces = false
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
    }
    
    private func setDelegate() {
        self.dataSource = self
        self.delegate = self
    }
}

extension MainTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainTableTypeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
    
        cell.setCell(modelType: mainTableTypeItems[indexPath.row])
        
        return cell
    }
}

extension MainTableView: UITableViewDelegate {
    
}
