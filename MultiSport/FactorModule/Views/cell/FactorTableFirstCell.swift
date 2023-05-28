//
//  FactorTableFirstCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 28/05/23.
//

import UIKit

class FactorTableFirstCell: UITableViewCell {
    
    static let identifier = "FactorTableFirstCell"
    
    // MARK: - UI Components
    private let homeKoef: UILabel = UILabel(text: "1", textColor: .systemGray5, font: .gothamBold15())
    private let nobodyKoef: UILabel = UILabel(text: "X", textColor: .systemGray5, font: .gothamBold15())
    private let awayKoef: UILabel = UILabel(text: "2", textColor: .systemGray5, font: .gothamBold15())
    
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
        self.addSubview(thirdVerticalView)
        self.addSubview(secondVerticalView)
        self.addSubview(firstVerticalView)
        self.addSubview(homeKoef)
        self.addSubview(nobodyKoef)
        self.addSubview(awayKoef)
        
    }
}

// MARK: - Constrains
extension FactorTableFirstCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            topView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 2),
            
            thirdVerticalView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            thirdVerticalView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            thirdVerticalView.widthAnchor.constraint(equalToConstant: 2),
//            thirdVerticalView.bottomAnchor.constraint(equalTo: self.bottomAnchor), // TODO: - я не понимаю что с чем конфликтуют эти констрейнты ????????
            thirdVerticalView.heightAnchor.constraint(equalToConstant: 40), // TODO: - сделал так - но это кринж
            
            secondVerticalView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            secondVerticalView.trailingAnchor.constraint(equalTo: thirdVerticalView.leadingAnchor, constant: -50),
            secondVerticalView.widthAnchor.constraint(equalToConstant: 2),
//            secondVerticalView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            secondVerticalView.heightAnchor.constraint(equalToConstant: 40),
            

            firstVerticalView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            firstVerticalView.trailingAnchor.constraint(equalTo: secondVerticalView.leadingAnchor, constant: -50),
            firstVerticalView.widthAnchor.constraint(equalToConstant: 2),
//            firstVerticalView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            firstVerticalView.heightAnchor.constraint(equalToConstant: 40),

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

