//
//  MatchesTeamTable.swift
//  MultiSport
//
//  Created by Витя Рябко on 19/04/23.
//

import UIKit

protocol StatisticMatchProtocol: AnyObject {
    func presentStatistic()
}

class MatchesTeamTable: UITableView {

    let headerMatchSectionView = HeaderMatchSectionView()
    
    weak var statisticMatchDelegate: StatisticMatchProtocol?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(MatchesTeamTableCell.self, forCellReuseIdentifier: MatchesTeamTableCell.identifier)
        
        config()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupUI
    private func config() {
        self.backgroundColor = .clear
        self.bounces = false
        self.showsVerticalScrollIndicator = false
    }
    
    // MARK: - setDelegate
    private func setDelegate() {
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
    }
    
    @objc private func didTapStatistiscButton(){
        statisticMatchDelegate?.presentStatistic()
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MatchesTeamTable: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        70
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerMatchSectionView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        260
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchesTeamTableCell.identifier, for: indexPath) as? MatchesTeamTableCell else {
            return UITableViewCell()
        }
        
        cell.statisticButton.addTarget(self, action: #selector(didTapStatistiscButton), for: .touchUpInside)
        
        return cell
    }
    
    
}


