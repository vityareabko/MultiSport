//
//  StatisticMatchTableView.swift
//  MultiSport
//
//  Created by Витя Рябко on 20/04/23.
//

import UIKit

class StatisticMatchTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(StatisticMatchTableViewCell.self, forCellReuseIdentifier: StatisticMatchTableViewCell.identifier)
        
        config()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        self.backgroundColor = .clear
    }
    
    private func setDelegate() {
        self.dataSource = self
        self.delegate = self
    }
}

extension StatisticMatchTableView : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticMatchTableViewCell.identifier, for: indexPath) as? StatisticMatchTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
