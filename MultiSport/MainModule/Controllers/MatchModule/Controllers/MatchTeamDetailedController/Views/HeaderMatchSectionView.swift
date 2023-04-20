//
//  HeaderMatchSectionView.swift
//  MultiSport
//
//  Created by Витя Рябко on 19/04/23.
//

import UIKit

protocol HeaderTapProtocol: AnyObject {
    func hideContentSection(index: Int)
}

class HeaderMatchSectionView : UIView {
    
    weak var headerTapDelegate : HeaderTapProtocol?
    var sectionIndex: Int?
    
    // MARK: - UI Components
    private let labelDate = UILabel(text: "19 Feb", textColor: .systemGray2, font: .gothamRegular12())
    
    private let labelTeamName1 = UILabel(text: "Milan", textColor: .systemGray5, font: .gothamBold16())
    private let labelTeamName2 = UILabel(text: "Real Madrid", textColor: .systemGray5, font: .gothamBold16())
    private let scoreTeam = UILabel(text: "1 : 0", textColor: .specialOrangeColor, font: .gothamBold24())

    
    private let logoTeam1 = UIImageView(imageName: "team1")
    private let logoTeam2 = UIImageView(imageName: "team2")
    
    private var stackViewTeam1 = UIStackView()
    private var stackViewTeam2 = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didtapSuperview))
        self.addGestureRecognizer(recognizer)
        
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didtapSuperview() {
        print("tap")
        guard let idx = sectionIndex else { return }
        headerTapDelegate?.hideContentSection(index: idx)
    }
    
    private func setupUI() {
        self.backgroundColor = .specialBagroubdSubviews
        self.layer.cornerRadius = 7
        
        labelDate.textAlignment = .center
        scoreTeam.textAlignment = .center
        labelTeamName2.textAlignment = .right
        
        setStackView()
        self.addSubview(labelDate)
        self.addSubview(scoreTeam)
        self.addSubview(stackViewTeam1)
        self.addSubview(stackViewTeam2)
    }
    
    // MARK: - set StackView
    private func setStackView() {
        stackViewTeam1 = UIStackView(arrangedSubviews: [labelTeamName1, logoTeam1])
        stackViewTeam1.axis = .horizontal
        stackViewTeam1.spacing = 10
        stackViewTeam1.distribution = .equalCentering
        stackViewTeam1.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewTeam2 = UIStackView(arrangedSubviews: [logoTeam2, labelTeamName2])
        stackViewTeam2.axis = .horizontal
        stackViewTeam2.spacing = 10
        stackViewTeam2.distribution = .equalCentering
        stackViewTeam2.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

extension HeaderMatchSectionView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            labelDate.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            labelDate.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            labelDate.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            labelDate.heightAnchor.constraint(equalToConstant: 13),
            
            logoTeam1.widthAnchor.constraint(equalToConstant: 30),
            logoTeam1.heightAnchor.constraint(equalToConstant: 30),
            logoTeam2.widthAnchor.constraint(equalToConstant: 30),
            logoTeam2.heightAnchor.constraint(equalToConstant: 30),
            
            scoreTeam.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 3),
            scoreTeam.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scoreTeam.heightAnchor.constraint(equalToConstant: 30),
            scoreTeam.widthAnchor.constraint(equalToConstant: 60),
            
            stackViewTeam1.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 3),
            stackViewTeam1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackViewTeam1.trailingAnchor.constraint(equalTo: scoreTeam.leadingAnchor, constant: -10),
            stackViewTeam1.heightAnchor.constraint(equalToConstant: 30),
            
            stackViewTeam2.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 3),
            stackViewTeam2.leadingAnchor.constraint(equalTo: scoreTeam.trailingAnchor, constant: 10),
            stackViewTeam2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackViewTeam2.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
