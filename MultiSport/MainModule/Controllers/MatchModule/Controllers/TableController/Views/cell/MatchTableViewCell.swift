//
//  MatchTableViewCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 06/04/23.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    
    static let identifier = "MatchTableViewCell"
    
    
    // MARK: - UI Components
    private let teamFirst = UILabel(text: "Mosc city", textColor: .systemGray5, font: .gothamRegular15())
    private let teamSecond = UILabel(text: "Ekatburg", textColor: .systemGray5, font: .gothamRegular15())
    
    private let teamFirsIcon = UIImageView(imageName: "mosk")
    private let teamSecondIcon = UIImageView(imageName: "ekatvurg")
    
    private let iconClock = UIImageView(imageName: "clock")
    private let timeStartMatchLabel = UILabel(text: "07:00", textColor: .specialOrangeColor, font: .gothamRegular15())
    private let dateLabel = UILabel(text: "17 Feb", textColor: .specialOrangeColor, font: .gothamRegular15())
    
    private let lineSeparatorTime: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lineSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBagroubdSubviews
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var timeAndDateStackViewVertical = UIStackView()
    private var commonStackView = UIStackView()
    private var teamFirstStackView = UIStackView()
    private var teamSecondStackView = UIStackView()

    
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
        setStackView()
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        dateLabel.textAlignment = .center
        iconClock.tintColor = .specialOrangeColor
        teamFirst.numberOfLines = 2
        teamFirst.textAlignment = .center
        teamSecond.numberOfLines = 2

        self.addSubview(commonStackView)
        self.addSubview(lineSeparator)
        self.addSubview(lineSeparatorTime)
        
        
        self.addSubview(timeAndDateStackViewVertical)
        self.addSubview(teamFirstStackView)
        self.addSubview(teamSecondStackView)
    }
    
    // MARK: - setup StackView
    private func setStackView() {
        let timeStackView = UIStackView(arrangedSubviews: [iconClock, timeStartMatchLabel])
        timeStackView.axis = .horizontal
        timeStackView.spacing = 3
        timeStackView.distribution = .fill
        
        timeAndDateStackViewVertical = UIStackView(arrangedSubviews: [dateLabel, lineSeparatorTime, timeStackView])
        timeAndDateStackViewVertical.axis = .vertical
        timeAndDateStackViewVertical.spacing = 3
        timeAndDateStackViewVertical.distribution = .equalCentering
        timeAndDateStackViewVertical.translatesAutoresizingMaskIntoConstraints = false
        
        teamFirstStackView = UIStackView(arrangedSubviews: [teamFirst, teamFirsIcon])
        teamFirstStackView.axis = .horizontal
        teamFirstStackView.spacing = 5
        teamFirstStackView.distribution = .equalSpacing
        teamFirstStackView.translatesAutoresizingMaskIntoConstraints = false
        
        teamSecondStackView = UIStackView(arrangedSubviews: [teamSecondIcon, teamSecond])
        teamSecondStackView.axis = .horizontal
        teamSecondStackView.spacing = 5
        teamSecondStackView.distribution = .equalSpacing
        teamSecondStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func setData(model: SportFixture) {
        teamFirst.text = model.teamHome
        teamSecond.text = model.teamAway
        teamFirsIcon.image = model.teamHomeIcon
        teamSecondIcon.image = model.teamAwayIcon
        
        print(model.teamHomeIcon)
        print(model.teamAwayIcon)
        
        let formaterDay = DateFormatter()
        formaterDay.dateFormat = "EEEEEEE dd"
        
        let formaterTime = DateFormatter()
        formaterTime.dateFormat = "HH:mm"
        

        let date = formaterDay.string(from: model.matchDate)
        let time = formaterTime.string(from: model.matchDate)

        timeStartMatchLabel.text = time
        dateLabel.text = date
        
    }
    
    
    // MARK: - Selectors
    
    
    
}

extension MatchTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            timeAndDateStackViewVertical.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeAndDateStackViewVertical.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timeAndDateStackViewVertical.heightAnchor.constraint(equalToConstant: 45),
            timeAndDateStackViewVertical.widthAnchor.constraint(equalToConstant: 70),
            
            teamFirstStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            teamFirstStackView.trailingAnchor.constraint(equalTo: timeAndDateStackViewVertical.leadingAnchor, constant: -10),
            teamFirstStackView.leadingAnchor.constraint(equalTo: lineSeparator.leadingAnchor, constant: 10),
            teamFirstStackView.heightAnchor.constraint(equalToConstant: 20),
            
            teamSecondStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            teamSecondStackView.leadingAnchor.constraint(equalTo: timeAndDateStackViewVertical.trailingAnchor, constant: 10),
            teamSecondStackView.trailingAnchor.constraint(equalTo: lineSeparator.trailingAnchor, constant: -10),
            teamSecondStackView.heightAnchor.constraint(equalToConstant: 20),
            
            lineSeparatorTime.widthAnchor.constraint(equalTo: timeAndDateStackViewVertical.widthAnchor, multiplier: 1),
            lineSeparatorTime.heightAnchor.constraint(equalToConstant: 2),
            lineSeparatorTime.centerYAnchor.constraint(equalTo: timeAndDateStackViewVertical.centerYAnchor),
            lineSeparatorTime.centerXAnchor.constraint(equalTo: timeAndDateStackViewVertical.centerXAnchor),
            
            lineSeparator.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.92),
            lineSeparator.heightAnchor.constraint(equalToConstant: 2),
            lineSeparator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            lineSeparator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            teamFirst.widthAnchor.constraint(equalToConstant: 70),
            teamSecond.widthAnchor.constraint(equalToConstant: 70),
        ])
    }
}
