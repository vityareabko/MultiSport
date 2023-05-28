//
//  HeaderMatchSectionView.swift
//  MultiSport
//
//  Created by Витя Рябко on 19/04/23.
//

import UIKit

protocol HeaderTapProtocol: AnyObject {
    func showContentSection(index: Int)
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
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBagroubdSubviews
        view.layer.cornerRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        guard let idx = sectionIndex else { return }
        headerTapDelegate?.showContentSection(index: idx)
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        
        labelDate.textAlignment = .center
        scoreTeam.textAlignment = .center
        labelTeamName2.textAlignment = .right
        
        setStackView()
        
        self.addSubview(backView)
        self.addSubview(separatorView)
        backView.addSubview(labelDate)
        backView.addSubview(scoreTeam)
        backView.addSubview(stackViewTeam1)
        backView.addSubview(stackViewTeam2)
        
        
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
    
    public func setData(model: PastFixturesByTeamID) {
        self.labelTeamName1.text = model.homeTeamName
        self.labelTeamName2.text = model.awayTeamName
        self.logoTeam1.image = model.logoHomeTeam
        self.logoTeam2.image = model.logoAwayTeam
        
        self.scoreTeam.text = model.score
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        
        self.labelDate.text = dateFormatter.string(from: model.dateFixture)
    }
    
}

extension HeaderMatchSectionView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: self.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backView.topAnchor.constraint(equalTo: self.topAnchor),
            backView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -15),
            
            labelDate.topAnchor.constraint(equalTo: backView.topAnchor, constant: 5),
            labelDate.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            labelDate.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            labelDate.heightAnchor.constraint(equalToConstant: 13),
            
            logoTeam1.widthAnchor.constraint(equalToConstant: 30),
            logoTeam1.heightAnchor.constraint(equalToConstant: 30),
            logoTeam2.widthAnchor.constraint(equalToConstant: 30),
            logoTeam2.heightAnchor.constraint(equalToConstant: 30),
            
            scoreTeam.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: 3),
            scoreTeam.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            scoreTeam.heightAnchor.constraint(equalToConstant: 30),
            scoreTeam.widthAnchor.constraint(equalToConstant: 60),
            
            stackViewTeam1.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: 3),
            stackViewTeam1.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            stackViewTeam1.trailingAnchor.constraint(equalTo: scoreTeam.leadingAnchor, constant: -10),
            stackViewTeam1.heightAnchor.constraint(equalToConstant: 30),
            
            stackViewTeam2.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: 3),
            stackViewTeam2.leadingAnchor.constraint(equalTo: scoreTeam.trailingAnchor, constant: 10),
            stackViewTeam2.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            stackViewTeam2.heightAnchor.constraint(equalToConstant: 30),
            
            
        ])
    }
}
