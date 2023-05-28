//
//  FactorTableViewCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 20/05/23.
//

import UIKit

class FactorTableViewCell: UITableViewCell {
    
    static let identifier = "FactorTableViewCell"
    
    // MARK: - UI Components
    private let homeKoef: UILabel = UILabel(text: "1", textColor: .systemGray5, font: .gothamBold15())
    private let nobodyKoef: UILabel = UILabel(text: "X", textColor: .systemGray5, font: .gothamBold15())
    private let awayKoef: UILabel = UILabel(text: "2", textColor: .systemGray5, font: .gothamBold15())

    private let lableHomeTeam = UILabel(text: "homeTeam", textColor: .systemGray5, font: .gothamBold15())
    private let lableAwayTeam = UILabel(text: "AwayTeam", textColor: .systemGray5, font: .gothamBold15())
    
    private let homeLogo = UIImageView(imageName: "factor1")
    private let awayLogo = UIImageView(imageName: "factor2")
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBagroubdSubviews
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let firstVerticalView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBagroubdSubviews
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let secondVerticalView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBagroubdSubviews
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let thirdVerticalView: UIView = {
        let view = UIView()
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
        
        homeKoef.textAlignment = .center
        nobodyKoef.textAlignment = .center
        awayKoef.textAlignment = .center
        
        self.addSubview(topView)
        self.addSubview(firstVerticalView)
        self.addSubview(secondVerticalView)
        self.addSubview(thirdVerticalView)
        self.addSubview(lableHomeTeam)
        self.addSubview(lableAwayTeam)
        self.addSubview(homeLogo)
        self.addSubview(awayLogo)
        self.addSubview(homeKoef)
        self.addSubview(nobodyKoef)
        self.addSubview(awayKoef)
    }
    
    
    func setData(model: FactorModel) {
//        self.testLabel.text = "\(model.kofNobody)"
        self.homeKoef.text = "\(model.kofHome)"
        self.nobodyKoef.text = "\(model.kofNobody)"
        self.awayKoef.text = "\(model.kofAway)"
        self.homeLogo.image = model.logoTeamHome
        self.awayLogo.image = model.logoTeamAway
        self.lableHomeTeam.text = "\(model.teamHome)"
        self.lableAwayTeam.text = "\(model.teamAway)"
    }

}

// MARK: - Constrains
extension FactorTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 2),
            
            thirdVerticalView.topAnchor.constraint(equalTo: self.topAnchor),
            thirdVerticalView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            thirdVerticalView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -50),
            thirdVerticalView.widthAnchor.constraint(equalToConstant: 2),

            secondVerticalView.topAnchor.constraint(equalTo: self.topAnchor),
            secondVerticalView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            secondVerticalView.trailingAnchor.constraint(equalTo: thirdVerticalView.leadingAnchor, constant: -50),
            secondVerticalView.widthAnchor.constraint(equalToConstant: 2),

            firstVerticalView.topAnchor.constraint(equalTo: self.topAnchor),
            firstVerticalView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            firstVerticalView.trailingAnchor.constraint(equalTo: secondVerticalView.leadingAnchor, constant: -50),
            firstVerticalView.widthAnchor.constraint(equalToConstant: 2),
            
            homeLogo.topAnchor.constraint(equalTo: firstVerticalView.centerYAnchor, constant: -19),
            homeLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            homeLogo.widthAnchor.constraint(equalToConstant: 24),
            homeLogo.heightAnchor.constraint(equalToConstant: 24),
            
            awayLogo.topAnchor.constraint(equalTo: homeLogo.bottomAnchor, constant: 5),
            awayLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            awayLogo.widthAnchor.constraint(equalToConstant: 24),
            awayLogo.heightAnchor.constraint(equalToConstant: 24),
            
            lableHomeTeam.centerYAnchor.constraint(equalTo: homeLogo.centerYAnchor),
            lableHomeTeam.leadingAnchor.constraint(equalTo: homeLogo.trailingAnchor, constant: 8),
            lableHomeTeam.trailingAnchor.constraint(equalTo: firstVerticalView.leadingAnchor, constant: -10),
         
            lableAwayTeam.centerYAnchor.constraint(equalTo: awayLogo.centerYAnchor),
            lableAwayTeam.leadingAnchor.constraint(equalTo: awayLogo.trailingAnchor, constant: 8),
            lableAwayTeam.trailingAnchor.constraint(equalTo: firstVerticalView.leadingAnchor, constant: -10),
            
            homeKoef.centerYAnchor.constraint(equalTo: firstVerticalView.centerYAnchor),
            homeKoef.leadingAnchor.constraint(equalTo: firstVerticalView.trailingAnchor),
            homeKoef.trailingAnchor.constraint(equalTo: secondVerticalView.leadingAnchor),
            
            nobodyKoef.centerYAnchor.constraint(equalTo: secondVerticalView.centerYAnchor),
            nobodyKoef.leadingAnchor.constraint(equalTo: secondVerticalView.trailingAnchor),
            nobodyKoef.trailingAnchor.constraint(equalTo: thirdVerticalView.leadingAnchor),
            
            awayKoef.centerYAnchor.constraint(equalTo: thirdVerticalView.centerYAnchor),
            awayKoef.leadingAnchor.constraint(equalTo: thirdVerticalView.trailingAnchor),
            awayKoef.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
        ])
    }
}

