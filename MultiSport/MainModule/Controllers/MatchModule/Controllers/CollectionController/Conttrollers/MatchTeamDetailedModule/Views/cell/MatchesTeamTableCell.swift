//
//  MatchesTeamTableCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 19/04/23.
//

import UIKit


class MatchesTeamTableCell: UITableViewCell {
    
    static let identifier = "MatchesTeamTableCell"
    
    // MARK: - UI Components
    private let footballFieldImage = UIImageView(imageName: "footballFieldImage")
    private let labelWinTeam = UILabel(text: "54%", textColor: .specialOrangeColor, font: .gothamBold24())
    private let labelLosseTeam = UILabel(text: "46%", textColor: .systemGray3, font: .gothamBold24())
    
    private let footballFieldleftPart: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let footballFieldRightPart: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.05
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var statisticButton = UIButton(text: "STATISTICS", textColor: .specialMainBaground, bgColor: .specialOrangeColor, font: .gothamBold15())
    
    // MARK: - init
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
        
        footballFieldImage.addSubview(labelWinTeam)
        footballFieldImage.addSubview(labelLosseTeam)
        footballFieldImage.contentMode = .scaleToFill
        footballFieldImage.image?.withRenderingMode(.alwaysTemplate)
        footballFieldImage.tintColor = .specialLight
        
        self.addSubview(footballFieldleftPart)
        self.addSubview(footballFieldRightPart)
        self.addSubview(footballFieldImage)
        self.contentView.addSubview(statisticButton)
    }
}

// MARK: - Extensions
extension MatchesTeamTableCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            footballFieldImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            footballFieldImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            footballFieldImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            footballFieldImage.heightAnchor.constraint(equalToConstant: 160),
            
            footballFieldleftPart.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            footballFieldleftPart.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            footballFieldleftPart.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            footballFieldleftPart.heightAnchor.constraint(equalToConstant: 160),
            
            footballFieldRightPart.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            footballFieldRightPart.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            footballFieldRightPart.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            footballFieldRightPart.heightAnchor.constraint(equalToConstant: 160),
            
            labelWinTeam.centerXAnchor.constraint(equalTo: footballFieldleftPart.centerXAnchor),
            labelWinTeam.centerYAnchor.constraint(equalTo: footballFieldleftPart.centerYAnchor),
            labelLosseTeam.centerXAnchor.constraint(equalTo: footballFieldRightPart.centerXAnchor),
            labelLosseTeam.centerYAnchor.constraint(equalTo: footballFieldRightPart.centerYAnchor),
   
            statisticButton.topAnchor.constraint(equalTo: footballFieldleftPart.bottomAnchor, constant: 20),
            statisticButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            statisticButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            statisticButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
