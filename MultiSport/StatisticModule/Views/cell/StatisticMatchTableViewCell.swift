//
//  StatisticMatchTableViewCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 20/04/23.
//

import UIKit

class StatisticMatchTableViewCell: UITableViewCell {
    
    static let identifier = "StatisticMatchTableViewCell"
    
    // MARK: - UI Components
    private let labelHomeTeam = UILabel(text: "54", textColor: .specialLight, font: .gothamBold20())
    private let labelAwayTeam = UILabel(text: "46", textColor: .specialLight, font: .gothamBold20())
    private let labelStatisticPoint = UILabel(text: "action areas", textColor: .systemGray5, font: .gothamBold18())
    
    private let topLine: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLight
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let verticalLeftLine: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLight
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let verticalRightLine: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLight
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - INit
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
        
        labelAwayTeam.textAlignment = .center
        labelHomeTeam.textAlignment = .center
        labelStatisticPoint.textAlignment = .center
        labelStatisticPoint.numberOfLines = 2
        labelStatisticPoint.text = labelStatisticPoint.text?.uppercased()

        self.addSubview(topLine)
        self.addSubview(verticalLeftLine)
        self.addSubview(verticalRightLine)
        self.addSubview(labelStatisticPoint)
        self.addSubview(labelAwayTeam)
        self.addSubview(labelHomeTeam)
    }
    
    public func setData(model: StatisticTypeValue) {
        self.labelStatisticPoint.text = model.type
        if let intValue = model.valueTeamHome, let intValue1 = model.valueTeamAway  {
            // изменяем текст лейбов
            self.labelHomeTeam.text = "\(intValue)"
            self.labelAwayTeam.text = "\(intValue1)"
            
            // проверяем какой value больше и меняем цвет
            self.labelHomeTeam.textColor = intValue > intValue1 ? .specialOrangeColor : .specialLight
            self.labelAwayTeam.textColor = intValue1 > intValue ? .specialOrangeColor : .specialLight
        }
        
        if let strValue = model.valueTeamHomeStr, let strValue1 = model.valueTeamAwayStr  {
            // изменяем текст лейбов
            self.labelHomeTeam.text = strValue
            self.labelAwayTeam.text = strValue1
            
            // так как у нас тут данные приходят в виде проценат "54.5%" то мы извлекаем только цыфры чтобы сравнит какой больше и изменить цвет
            let intValue = strValue.filter { $0.isNumber }
            let intValue1 = strValue1.filter { $0.isNumber }
            
            // проверяем какой value больше и меняем цвет
            self.labelHomeTeam.textColor = intValue > intValue1 ? .specialOrangeColor : .specialLight
            self.labelAwayTeam.textColor = intValue1 > intValue ? .specialOrangeColor : .specialLight
        }

    }
}

// MARK: - Extensions
extension StatisticMatchTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            topLine.topAnchor.constraint(equalTo: self.topAnchor),
            topLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            topLine.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            topLine.heightAnchor.constraint(equalToConstant: 0.5),
            
            verticalLeftLine.topAnchor.constraint(equalTo: self.topAnchor),
            verticalLeftLine.leadingAnchor.constraint(equalTo: topLine.leadingAnchor, constant: 75),
            verticalLeftLine.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            verticalLeftLine.widthAnchor.constraint(equalToConstant: 0.5),
            
            verticalRightLine.topAnchor.constraint(equalTo: self.topAnchor),
            verticalRightLine.trailingAnchor.constraint(equalTo: topLine.trailingAnchor, constant: -75),
            verticalRightLine.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            verticalRightLine.widthAnchor.constraint(equalToConstant: 0.5),
            
            labelHomeTeam.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            labelHomeTeam.leadingAnchor.constraint(equalTo: topLine.leadingAnchor, constant: 10),
            labelHomeTeam.trailingAnchor.constraint(equalTo: verticalLeftLine.leadingAnchor, constant: -10),
            labelHomeTeam.heightAnchor.constraint(equalToConstant: 22),
            
            labelStatisticPoint.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            labelStatisticPoint.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelStatisticPoint.widthAnchor.constraint(equalToConstant: 160),
            labelStatisticPoint.heightAnchor.constraint(equalToConstant: 50),
            
            labelAwayTeam.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            labelAwayTeam.trailingAnchor.constraint(equalTo: topLine.trailingAnchor, constant: -10),
            labelAwayTeam.leadingAnchor.constraint(equalTo: verticalRightLine.trailingAnchor, constant: 10),
            labelAwayTeam.heightAnchor.constraint(equalToConstant: 22),
            
            
        ])
    }
}
