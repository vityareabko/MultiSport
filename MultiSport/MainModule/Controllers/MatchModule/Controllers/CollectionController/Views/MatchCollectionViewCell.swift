//
//  MatchCollectionViewCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 10/04/23.
//

import UIKit

class MatchCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MatchCollectionViewCell"
    
    // MARK: - UI Components
    private let teamImage = UIImageView(imageName: "team1")
    private let teamlabel = UILabel(text: "Team", textColor: .systemGray5, font: .gothamBold13())
    
    
    // MARK: - INit
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.backgroundColor = .none
        teamlabel.textAlignment = .center
        teamlabel.text = teamlabel.text?.uppercased()
        self.addSubview(teamlabel)
        self.addSubview(teamImage)
    }
    
    public func setData(model: TeamModel) {
        self.teamlabel.text = model.teamName.uppercased()
        self.teamImage.image = model.teamLogo
    }
}

// MARK: - Extensions
extension MatchCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            teamImage.topAnchor.constraint(equalTo: self.topAnchor),
            teamImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            teamImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            teamImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            
            teamlabel.topAnchor.constraint(equalTo: teamImage.bottomAnchor, constant: 10),
            teamlabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            teamlabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            teamlabel.heightAnchor.constraint(equalToConstant: 15),
            
        ])
    }
}
