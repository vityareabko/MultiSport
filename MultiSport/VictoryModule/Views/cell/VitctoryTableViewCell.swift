//
//  VitctoryTableViewCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 31/05/23.
//

import UIKit

class VitctoryTableViewCell: UITableViewCell {
    
    static let identifier = "VitctoryTableViewCell"
    
    // MARK: - UI Components
    private let dataEventLabel = UILabel(text: "3 JAN 2023, 01:00 PM", textColor: .systemGray5, font: .gothamBold15())
    private let teamHomeLabel = UILabel(text: "Real Madrid", textColor: .systemGray5, font: .gothamBold13())
    private let teamAwayLabel = UILabel(text: "Barcelona", textColor: .systemGray5, font: .gothamBold13())
    private let scoreLabel = UILabel(text: "0 : 2", textColor: .specialOrangeColor, font: .gothamBold24())
    
    private let teamHomeIcon = UIImageView(imageName: "team4")
    private let teamAwayIcon = UIImageView(imageName: "team5")
    
    private let back: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .specialBagroubdSubviews
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
        
        dataEventLabel.textAlignment = .center
        
        self.addSubview(back)
        back.addSubview(dataEventLabel)
        back.addSubview(teamHomeIcon)
        back.addSubview(teamAwayIcon)
        back.addSubview(teamHomeLabel)
        back.addSubview(teamAwayLabel)
        back.addSubview(scoreLabel)
    }
}

// MARK: - Constrains
extension VitctoryTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            back.topAnchor.constraint(equalTo: topAnchor, constant: 7.5),
            back.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            back.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            back.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7.5),
            
            dataEventLabel.topAnchor.constraint(equalTo: back.topAnchor, constant: 20),
            dataEventLabel.leadingAnchor.constraint(equalTo: back.leadingAnchor),
            dataEventLabel.trailingAnchor.constraint(equalTo: back.trailingAnchor),
            
            teamHomeIcon.topAnchor.constraint(equalTo: dataEventLabel.bottomAnchor, constant: 5),
            teamHomeIcon.leadingAnchor.constraint(equalTo: back.leadingAnchor, constant: 25),
            teamHomeIcon.widthAnchor.constraint(equalToConstant: 60),
            teamHomeIcon.heightAnchor.constraint(equalToConstant: 60),
            
            teamAwayIcon.topAnchor.constraint(equalTo: dataEventLabel.bottomAnchor, constant: 5),
            teamAwayIcon.trailingAnchor.constraint(equalTo: back.trailingAnchor, constant: -25),
            teamAwayIcon.widthAnchor.constraint(equalToConstant: 60),
            teamAwayIcon.heightAnchor.constraint(equalToConstant: 60),
            
            teamHomeLabel.centerXAnchor.constraint(equalTo: teamHomeIcon.centerXAnchor),
            teamHomeLabel.topAnchor.constraint(equalTo: teamHomeIcon.bottomAnchor, constant: 13),
            
            teamAwayLabel.centerXAnchor.constraint(equalTo: teamAwayIcon.centerXAnchor),
            teamAwayLabel.topAnchor.constraint(equalTo: teamAwayIcon.bottomAnchor, constant: 13),
            
            scoreLabel.centerXAnchor.constraint(equalTo: back.centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: back.centerYAnchor),
        ])
    }
}

