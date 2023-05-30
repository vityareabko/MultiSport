//
//  LeagueTableViewCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 30/05/23.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {
    
    static let identifier = "LeagueTableViewCell"
    
    // MARK: - UI Components
    private let leagueTitleLabel = UILabel(text: "Premier League", textColor: .systemGray5, font: .gothamBold15())
    private let iconLeague = UIImageView(imageName: "factor1")
    
    private let topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLight
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.addSubview(topSeparator)
        self.addSubview(iconLeague)
        self.addSubview(leagueTitleLabel)
    }
}

// MARK: - Constrains
extension LeagueTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: topAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            topSeparator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            topSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            iconLeague.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconLeague.leadingAnchor.constraint(equalTo: topSeparator.leadingAnchor, constant: 20),
            iconLeague.heightAnchor.constraint(equalToConstant: 30),
            iconLeague.widthAnchor.constraint(equalToConstant: 30),
            
            leagueTitleLabel.centerYAnchor.constraint(equalTo: iconLeague.centerYAnchor),
            leagueTitleLabel.leadingAnchor.constraint(equalTo: iconLeague.trailingAnchor, constant: 13),
            leagueTitleLabel.trailingAnchor.constraint(equalTo: topSeparator.trailingAnchor, constant: -20),
        ])
    }
}

