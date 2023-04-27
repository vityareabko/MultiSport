//
//  EventByDateTableViewCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 27/04/23.
//

import UIKit

class EventByDateTableViewCell: UITableViewCell {
    
    static let identifier = "EventByDateTableViewCell"
    
    
    // MARK: - UI Components
    private let leagueTitleLabel = UILabel(text: "CHAMPIONS LEAGUE", textColor: .specialLight, font: .gothamRegular10())
    private let teamFirst = UILabel(text: "Mosc city", textColor: .systemGray5, font: .gothamRegular15())
    private let teamSecond = UILabel(text: "Ekatburg", textColor: .systemGray5, font: .gothamRegular15())
    
    private let teamFirsIcon = UIImageView(imageName: "team1")
    private let teamSecondIcon = UIImageView(imageName: "team2")
    
    private let timeStartMatchLabel = UILabel(text: "07:00", textColor: .specialOrangeColor, font: .gothamRegular13())
    private let dateLabel = UILabel(text: "17 Feb", textColor: .systemGray5, font: .gothamRegular13())
    
    private let lineSeparatorTime: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let back: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .specialBagroubdSubviews
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var timeAndDateStackViewVertical = UIStackView()
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
        timeStartMatchLabel.textAlignment = .center
        teamFirst.numberOfLines = 2
        teamFirst.textAlignment = .center
        teamSecond.numberOfLines = 2

        self.addSubview(back)
        self.addSubview(leagueTitleLabel)
        
        back.addSubview(lineSeparatorTime)
        back.addSubview(timeAndDateStackViewVertical)
        back.addSubview(teamFirstStackView)
        back.addSubview(teamSecondStackView)
    }
    
    // MARK: - setup StackView
    private func setStackView() {
        let timeStackView = UIStackView(arrangedSubviews: [timeStartMatchLabel])
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
    
//    public func setData(model: SportFixture) {
//        teamFirst.text = model.teamHome
//        teamSecond.text = model.teamAway
//        teamFirsIcon.image = model.teamHomeIcon
//        teamSecondIcon.image = model.teamAwayIcon
//
//        let formaterDay = DateFormatter()
//        formaterDay.dateFormat = "EEEEEEE dd"
//
//        let formaterTime = DateFormatter()
//        formaterTime.dateFormat = "HH:mm"
//
//
//        let date = formaterDay.string(from: model.matchDate)
//        let time = formaterTime.string(from: model.matchDate)
//
//        timeStartMatchLabel.text = time
//        dateLabel.text = date
//
//    }
}

extension EventByDateTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            back.topAnchor.constraint(equalTo: self.topAnchor, constant: 7.5),
            back.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            back.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            back.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7.5),
            
            leagueTitleLabel.topAnchor.constraint(equalTo: back.topAnchor, constant: 5),
            leagueTitleLabel.centerXAnchor.constraint(equalTo: back.centerXAnchor),
            leagueTitleLabel.heightAnchor.constraint(equalToConstant: 13),
            
            timeAndDateStackViewVertical.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeAndDateStackViewVertical.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 5),
            timeAndDateStackViewVertical.heightAnchor.constraint(equalToConstant: 45),
            timeAndDateStackViewVertical.widthAnchor.constraint(equalToConstant: 70),
            
            teamFirstStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 5),
            teamFirstStackView.trailingAnchor.constraint(equalTo: timeAndDateStackViewVertical.leadingAnchor, constant: -10),
            teamFirstStackView.leadingAnchor.constraint(equalTo: back.leadingAnchor, constant: 20),
            teamFirstStackView.heightAnchor.constraint(equalToConstant: 20),
            
            teamSecondStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 5),
            teamSecondStackView.leadingAnchor.constraint(equalTo: timeAndDateStackViewVertical.trailingAnchor, constant: 10),
            teamSecondStackView.trailingAnchor.constraint(equalTo: back.trailingAnchor, constant: -20),
            teamSecondStackView.heightAnchor.constraint(equalToConstant: 20),
            
            lineSeparatorTime.widthAnchor.constraint(equalTo: timeAndDateStackViewVertical.widthAnchor, multiplier: 1),
            lineSeparatorTime.heightAnchor.constraint(equalToConstant: 2),
            lineSeparatorTime.centerYAnchor.constraint(equalTo: timeAndDateStackViewVertical.centerYAnchor),
            lineSeparatorTime.centerXAnchor.constraint(equalTo: timeAndDateStackViewVertical.centerXAnchor),
            
            teamFirst.widthAnchor.constraint(equalToConstant: 70),
            teamSecond.widthAnchor.constraint(equalToConstant: 70),
        ])
    }
}
