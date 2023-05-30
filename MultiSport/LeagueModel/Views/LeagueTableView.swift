//
//  LeagueTableView.swift
//  MultiSport
//
//  Created by Витя Рябко on 30/05/23.
//

import UIKit

class LeagueTableView : UITableView {
    
    
    // MARK: - init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(LeagueTableViewCell.self, forCellReuseIdentifier: LeagueTableViewCell.identifier)
        
        config()
        setDelegate()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    private func config() {
        backgroundColor = .clear
        bounces = false
        showsVerticalScrollIndicator = false
    }
    
    // MARK: - setDelgate
    private func setDelegate() {
        delegate = self
        dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LeagueTableView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeagueTableViewCell.identifier, for: indexPath) as? LeagueTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}

