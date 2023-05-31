//
//  BetView.swift
//  MultiSport
//
//  Created by Витя Рябко on 31/05/23.
//

import UIKit

class BetView: UIView {
    
    // MARK: - UI Components
    private let teamHomeIcon = UIImageView(imageName: "team1")
    private let teamAwayIcon = UIImageView(imageName: "team4")
    
    private let dataEventLabel = UILabel(text: "3 JAN 2023, 01:00 PM", textColor: .systemGray5, font: .gothamBold13())
    private let teamHomeLabel = UILabel(text: "Real Madrid", textColor: .systemGray5, font: .gothamBold13())
    private let teamAwayLabel = UILabel(text: "Barcelona", textColor: .systemGray5, font: .gothamBold13())
    
    private let winLabel = UILabel(text: "WIN", textColor: .systemGray5, font: .gothamBold15())
    private let drawLabel = UILabel(text: "DRAW", textColor: .systemGray5, font: .gothamBold15())
    private let win2Label = UILabel(text: "WIN 2", textColor: .systemGray5, font: .gothamBold15())
    
    private let betButton = UIButton(text: "BET", textColor: .specialMainBaground, bgColor: .specialOrangeColor, font: .gothamBold20())
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLight
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let winTextField = UITextField(placeholder: "", bgColor: #colorLiteral(red: 0.2352941176, green: 0.3098039216, blue: 0.368627451, alpha: 1))
    private let drawTextField = UITextField(placeholder: "", bgColor: #colorLiteral(red: 0.2352941176, green: 0.3098039216, blue: 0.368627451, alpha: 1))
    private let win2TextField = UITextField(placeholder: "", bgColor: #colorLiteral(red: 0.2352941176, green: 0.3098039216, blue: 0.368627451, alpha: 1))
    
    private var stackViewBet = UIStackView()
 
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.backgroundColor = .specialBagroubdSubviews
        self.layer.cornerRadius = 7
        
        winLabel.textAlignment = .center
        win2Label.textAlignment = .center
        drawLabel.textAlignment = .center
        dataEventLabel.textAlignment = .center
        teamHomeLabel.textAlignment = .center
        teamAwayLabel.textAlignment = .center
        
        setStackView()
        
        self.addSubview(teamHomeIcon)
        self.addSubview(teamHomeLabel)
        self.addSubview(teamAwayIcon)
        self.addSubview(teamAwayLabel)
        self.addSubview(dataEventLabel)
        self.addSubview(line)
        self.addSubview(stackViewBet)
        self.addSubview(betButton)
    }
    
    private func setStackView() {
        let stackViewWin = UIStackView(arrangedSubviews: [winLabel, winTextField])
        stackViewWin.axis = .vertical
        stackViewWin.spacing = 3
        stackViewWin.distribution = .fillProportionally
        
        let stackViewWin2 = UIStackView(arrangedSubviews: [win2Label, win2TextField])
        stackViewWin2.axis = .vertical
        stackViewWin2.spacing = 3
        stackViewWin2.distribution = .fillProportionally
        
        let stackViewDraw = UIStackView(arrangedSubviews: [drawLabel, drawTextField])
        stackViewDraw.axis = .vertical
        stackViewDraw.spacing = 3
        stackViewDraw.distribution = .fillProportionally
        
        stackViewBet = UIStackView(arrangedSubviews: [stackViewWin, stackViewDraw, stackViewWin2])
        stackViewBet.axis = .horizontal
        stackViewBet.spacing = 30
        stackViewBet.distribution = .fillEqually
        
        stackViewBet.translatesAutoresizingMaskIntoConstraints = false
        
//        stackViewWin.translatesAutoresizingMaskIntoConstraints = false
//        stackViewWin2.translatesAutoresizingMaskIntoConstraints = false
//        stackViewDraw.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Constrains
extension BetView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            teamHomeIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            teamHomeIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            teamHomeIcon.widthAnchor.constraint(equalToConstant: 50),
            teamHomeIcon.heightAnchor.constraint(equalToConstant: 50),
            
            teamHomeLabel.topAnchor.constraint(equalTo: teamHomeIcon.bottomAnchor, constant: 10),
            teamHomeLabel.leadingAnchor.constraint(equalTo: teamHomeIcon.leadingAnchor, constant: -10),
            teamHomeLabel.trailingAnchor.constraint(equalTo: teamHomeIcon.trailingAnchor, constant: 10),
            
            teamAwayIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            teamAwayIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            teamAwayIcon.widthAnchor.constraint(equalToConstant: 50),
            teamAwayIcon.heightAnchor.constraint(equalToConstant: 50),
            
            teamAwayLabel.topAnchor.constraint(equalTo: teamAwayIcon.bottomAnchor, constant: 10),
            teamAwayLabel.leadingAnchor.constraint(equalTo: teamAwayIcon.leadingAnchor, constant: -10),
            teamAwayLabel.trailingAnchor.constraint(equalTo: teamAwayIcon.trailingAnchor, constant: 10),
            
            dataEventLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            dataEventLabel.leadingAnchor.constraint(equalTo: teamHomeIcon.trailingAnchor, constant: 10),
            dataEventLabel.trailingAnchor.constraint(equalTo: teamAwayIcon.leadingAnchor, constant: -10),
            
            line.topAnchor.constraint(equalTo: teamAwayLabel.bottomAnchor, constant: 15),
            line.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            line.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            line.heightAnchor.constraint(equalToConstant: 1),
            
            winTextField.heightAnchor.constraint(equalToConstant: 50),
            drawTextField.heightAnchor.constraint(equalToConstant: 50),
            win2TextField.heightAnchor.constraint(equalToConstant: 50),
            
            stackViewBet.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 15),
            stackViewBet.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackViewBet.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackViewBet.heightAnchor.constraint(equalToConstant: 90),
            
            betButton.topAnchor.constraint(equalTo: stackViewBet.bottomAnchor, constant: 25),
            betButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            betButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            betButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
