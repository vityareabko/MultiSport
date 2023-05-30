//
//  FavoriteFutureMatchesTableView.swift
//  MultiSport
//
//  Created by Витя Рябко on 30/05/23.
//


import UIKit

class FavoriteFutureMatchesTableView : UITableView {
    
    
    // MARK: - init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(FavoriteMatchesTVCell.self, forCellReuseIdentifier: FavoriteMatchesTVCell.identifier)
        
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
extension FavoriteFutureMatchesTableView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMatchesTVCell.identifier, for: indexPath) as? FavoriteMatchesTVCell else {
            return UITableViewCell()
        }
        
        cell.dataCommingMatch()
        
        return cell
    }
}

