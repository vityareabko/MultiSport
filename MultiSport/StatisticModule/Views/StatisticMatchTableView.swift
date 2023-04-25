//
//  StatisticMatchTableView.swift
//  MultiSport
//
//  Created by Витя Рябко on 20/04/23.
//

import UIKit

class StatisticMatchTableView: UITableView {
    
    private var statsTeams = [StatisticTypeValue]()
    
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
    
    public func setData(_ stats: [StatisticTypeValue]){
        self.statsTeams = stats
    }
}


extension StatisticMatchTableView : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.statsTeams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticMatchTableViewCell.identifier, for: indexPath) as? StatisticMatchTableViewCell else {
            return UITableViewCell()
        }
        
        
        cell.setData(model: self.statsTeams[indexPath.row])
        return cell
    }
}
