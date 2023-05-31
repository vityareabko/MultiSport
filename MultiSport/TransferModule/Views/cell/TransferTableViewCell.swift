//
//  TransferTableViewCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 31/05/23.
//


import UIKit

class TransferTableViewCell: UITableViewCell {
    
    static let identifier = "TransferTableViewCell"
    
    // MARK: - UI Components
    private let iconTransfer = UIImageView(imageName: "defaultIconTransfer")
    private let team1 = UIImageView(imageName: "team1")
    private let team2 = UIImageView(imageName: "team2")
    private let arrow = UIImageView(imageName: "orangeArrow")
    
    private let priceTransferLabel: UILabel = UILabel(text: "€ 100 MLN", textColor: .systemGray5, font: .gothamBold16())
    private let playerLabel: UILabel = UILabel(text: "FOOTBALL PLAYER", textColor: .systemGray5, font: .gothamBold16())
    
    private let topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLight
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var stackViewVertical = UIStackView()
    private var stackViewIcons = UIStackView()
    
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
        
        setStackView()
        priceTransferLabel.textAlignment = .center
        playerLabel.textAlignment = .center
        
        self.addSubview(topSeparator)
        self.addSubview(iconTransfer)
        self.addSubview(stackViewVertical)

    }
    
    private func setStackView() {
        stackViewIcons = UIStackView(arrangedSubviews: [team1, arrow, team2])
        stackViewIcons.axis = .horizontal
        stackViewIcons.spacing = 5
        stackViewIcons.distribution = .equalSpacing
        
//        team1.backgroundColor = .red
//        team2.backgroundColor = .red
//        arrow.backgroundColor = .red
        
        stackViewVertical = UIStackView(arrangedSubviews: [priceTransferLabel, stackViewIcons, playerLabel])
        stackViewVertical.axis = .vertical
        stackViewVertical.spacing = 5
        stackViewVertical.distribution = .fillEqually
        
        stackViewVertical.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Constrains
extension TransferTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: topAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            topSeparator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            topSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            iconTransfer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconTransfer.leadingAnchor.constraint(equalTo: topSeparator.leadingAnchor, constant: 20),
            iconTransfer.heightAnchor.constraint(equalToConstant: 80),
            iconTransfer.widthAnchor.constraint(equalToConstant: 80),
            
            

//            team1.widthAnchor.constraint(equalToConstant: 75),
//            team2.widthAnchor.constraint(equalToConstant: 75),
//            arrow.widthAnchor.constraint(equalToConstant: 75),
//
            stackViewVertical.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackViewVertical.leadingAnchor.constraint(equalTo: iconTransfer.trailingAnchor, constant: 30),
//            stackViewVertical.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackViewVertical.heightAnchor.constraint(equalToConstant: 100),
            stackViewIcons.widthAnchor.constraint(equalToConstant: 180),
            
//            stackViewIcons.heightAnchor.constraint(equalToConstant: 75),
        ])
    }
}

