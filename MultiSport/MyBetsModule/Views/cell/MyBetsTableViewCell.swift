//
//  MyBetsTableViewCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 31/05/23.
//

import UIKit

class MyBetsTableViewCell: UITableViewCell {
    
    static let identifier = "MyBetsTableViewCell"
    
    // MARK: - UI Components
    private let teamHomeIcon = UIImageView(imageName: "team2")
    private let teamAwayIcon = UIImageView(imageName: "team3")
    
    private let dateEventLabel = UILabel(text: "Dec 23", textColor: .specialLight, font: .gothamRegular12())
    private let teamHomeLabel = UILabel(text: "PSG", textColor: .systemGray5, font: .gothamRegular15())
    private let teamAwayLabel = UILabel(text: "BOYER", textColor: .systemGray5, font: .gothamRegular15())
    private let scoreLabel = UILabel(text: "3 : 0", textColor: .specialOrangeColor, font: .gothamBold24())
    
    private let profitLabel = UILabel(text: "50", textColor: .specialMainBaground, font: .gothamBold16())
    private let profitView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5411764706, green: 0.8745098039, blue: 0.7137254902, alpha: 1)
        view.layer.cornerRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separatorLineView: UIView = {
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
        
        dateEventLabel.textAlignment = .center
        teamHomeLabel.textAlignment = .right
        
        self.addSubview(separatorLineView)
        self.addSubview(dateEventLabel)
        self.addSubview(scoreLabel)
        self.addSubview(teamHomeIcon)
        self.addSubview(teamHomeLabel)
        self.addSubview(teamAwayIcon)
        self.addSubview(teamAwayLabel)
        self.addSubview(profitView)
        profitView.addSubview(profitLabel)
    }
}

// MARK: - Constrains
extension MyBetsTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            separatorLineView.topAnchor.constraint(equalTo: topAnchor),
            separatorLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            separatorLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            separatorLineView.heightAnchor.constraint(equalToConstant: 1),
            
            dateEventLabel.topAnchor.constraint(equalTo: separatorLineView.bottomAnchor, constant: 9),
            dateEventLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dateEventLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            scoreLabel.topAnchor.constraint(equalTo: dateEventLabel.bottomAnchor, constant: 8),
            scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            teamHomeIcon.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
            teamHomeIcon.trailingAnchor.constraint(equalTo: scoreLabel.leadingAnchor, constant: -25),
            teamHomeIcon.widthAnchor.constraint(equalToConstant: 30),
            teamHomeIcon.heightAnchor.constraint(equalToConstant: 30),

            teamHomeLabel.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
            teamHomeLabel.trailingAnchor.constraint(equalTo: teamHomeIcon.leadingAnchor, constant: -15),
            teamHomeLabel.leadingAnchor.constraint(equalTo: separatorLineView.leadingAnchor, constant: 15),
//
            teamAwayIcon.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
            teamAwayIcon.leadingAnchor.constraint(equalTo: scoreLabel.trailingAnchor, constant: 25),
            teamAwayIcon.widthAnchor.constraint(equalToConstant: 30),
            teamAwayIcon.heightAnchor.constraint(equalToConstant: 30),

            teamAwayLabel.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
            teamAwayLabel.leadingAnchor.constraint(equalTo: teamAwayIcon.trailingAnchor, constant: 15),
            teamAwayLabel.trailingAnchor.constraint(equalTo: separatorLineView.trailingAnchor, constant: -15),
            
            profitView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 13),
            profitView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profitView.widthAnchor.constraint(equalToConstant: 57),
            profitView.heightAnchor.constraint(equalToConstant: 22),
            
            profitLabel.centerXAnchor.constraint(equalTo: profitView.centerXAnchor),
            profitLabel.centerYAnchor.constraint(equalTo: profitView.centerYAnchor),
            
        ])
    }
}

