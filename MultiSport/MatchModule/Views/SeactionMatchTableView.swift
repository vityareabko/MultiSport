//
//  SeactionMatchTableView.swift
//  MultiSport
//
//  Created by Витя Рябко on 08/04/23.
//

import UIKit

class SeactionMatchTableView: UIView {
    
    // MARK: - UIComponent
    private let sectionLabel = UILabel(text: "Section Liga", textColor: .systemGray2, font: .gothamRegular12())
    
    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .specialBagroubdSubviews
        self.layer.cornerRadius = 7
        
        sectionLabel.textAlignment = .center
        sectionLabel.text = sectionLabel.text?.uppercased()
        
        self.addSubview(sectionLabel)
        self.addSubview(bottomLine)
    }
    
    public func setLabel(textLabel: String) {
        sectionLabel.text = textLabel.uppercased()
    }
}

// MARK: - Extensions
extension SeactionMatchTableView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            sectionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            sectionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            sectionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            sectionLabel.heightAnchor.constraint(equalToConstant: 13),
            
            bottomLine.heightAnchor.constraint(equalToConstant: 2),
            bottomLine.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45),
            bottomLine.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 3),
            bottomLine.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
