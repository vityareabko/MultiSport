//
//  FavoriteTableViewCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 30/05/23.
//

import UIKit

class FavoriteMatchesTVCell: UITableViewCell {
    
    static let identifier = "FavoriteTableViewCell"
    
    // MARK: - UI Components
    private let sportICon = UIImageView(imageName: "football")
    private let fovoriteICon = UIImageView(imageName: "favoriteIcon")
    private let temaHomeIcon = UIImageView(imageName: "team1")
    private let temaAwayIcon = UIImageView(imageName: "team2")
    
    private let dateEvent = UILabel(text: "Dec 30", textColor: .specialLight, font: .gothamRegular12())
    private let scoreLabel = UILabel(text: "3 : 2", textColor: .specialOrangeColor, font: .gothamBold24())
    private let homeTeamLable = UILabel(text: "Real Madrid", textColor: .systemGray5, font: .gothamRegular15())
    private let awayTeamLable = UILabel(text: "Barcelona", textColor: .systemGray5, font: .gothamRegular15())
    
    
    private let back: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBagroubdSubviews
        view.layer.cornerRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var stackViewTopCell = UIStackView()
    private var stackViewBottomCell = UIStackView()
    
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
        
        sportICon.tintColor = .specialOrangeColor
        
        setStackView()
        
        self.addSubview(back)
        back.addSubview(stackViewTopCell)
        back.addSubview(stackViewBottomCell)
    }
    
    private func setStackView() {
        stackViewTopCell = UIStackView(arrangedSubviews: [sportICon, dateEvent, fovoriteICon])
        stackViewTopCell.axis = .horizontal
        stackViewTopCell.spacing = 4
        stackViewTopCell.distribution = .equalCentering
        
        let homeTeamStack = UIStackView(arrangedSubviews: [homeTeamLable,temaHomeIcon])
        homeTeamStack.axis = .horizontal
        homeTeamStack.spacing = 3
        homeTeamStack.distribution = .equalSpacing
        
        
        let awayTeamStack = UIStackView(arrangedSubviews: [temaAwayIcon, awayTeamLable])
        awayTeamStack.axis = .horizontal
        awayTeamStack.spacing = 3
        awayTeamStack.distribution = .equalSpacing
        
        stackViewBottomCell = UIStackView(arrangedSubviews: [homeTeamStack, scoreLabel, awayTeamStack])
        stackViewBottomCell.axis = .horizontal
        stackViewBottomCell.spacing = 4
        stackViewBottomCell.distribution = .equalCentering
        
        stackViewTopCell.translatesAutoresizingMaskIntoConstraints = false
        stackViewBottomCell.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func dataCommingMatch() {
        scoreLabel.textColor = .systemGray5
        scoreLabel.text = "0 : 0"
    }
    func dataCompletedgMatch() {
        scoreLabel.textColor = .specialOrangeColor
        scoreLabel.text = "3 : 2"
    }
}

// MARK: - Constrains
extension FavoriteMatchesTVCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            back.topAnchor.constraint(equalTo: topAnchor, constant: 7.5),
            back.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            back.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            back.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7.5),
            
            sportICon.widthAnchor.constraint(equalToConstant: 20),
            fovoriteICon.widthAnchor.constraint(equalToConstant: 20),
            
            stackViewTopCell.topAnchor.constraint(equalTo: back.topAnchor, constant: 12),
            stackViewTopCell.leadingAnchor.constraint(equalTo: back.leadingAnchor, constant: 20),
            stackViewTopCell.trailingAnchor.constraint(equalTo: back.trailingAnchor, constant: -20),
            stackViewTopCell.heightAnchor.constraint(equalToConstant: 20),
            
            stackViewBottomCell.topAnchor.constraint(equalTo: stackViewTopCell.bottomAnchor, constant: 8),
            stackViewBottomCell.leadingAnchor.constraint(equalTo: back.leadingAnchor, constant: 20),
            stackViewBottomCell.trailingAnchor.constraint(equalTo: back.trailingAnchor, constant: -20),
            stackViewBottomCell.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}

