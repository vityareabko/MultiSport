//
//  MainTableViewCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 04/04/23.
//

import UIKit

class MainTableViewCell : UITableViewCell {
    
    static let identifier = "MainTableViewCell"
    
    // MARK: - Ui Components
    private var iconCell = UIImageView(imageName: "team1")
    private var titleCell = UILabel(text: "Error", textColor: .systemGray5, font: .gothamBold18())
    private var arrowIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")?.withTintColor(.systemGray5, renderingMode: .alwaysOriginal)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let wrappCell: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBagroubdSubviews
        view.layer.cornerRadius = 10
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
    
    // MARK: - Setup UI
    private func setupUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none

        
        self.addSubview(wrappCell)
        wrappCell.addSubview(iconCell)
        wrappCell.addSubview(titleCell)
        wrappCell.addSubview(arrowIcon)

    }
    
    // MARK: - Setings
    public func setCell(modelType: MainTablesTypeItem) {
        self.iconCell.image = modelType.image
        self.titleCell.text = modelType.title
    }
    
}


// MARK: - Extensions
extension MainTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            wrappCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            wrappCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            wrappCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            wrappCell.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            iconCell.centerYAnchor.constraint(equalTo: wrappCell.centerYAnchor),
            iconCell.leadingAnchor.constraint(equalTo: wrappCell.leadingAnchor, constant: 10),
            iconCell.widthAnchor.constraint(equalTo: wrappCell.heightAnchor, multiplier: 0.70),
            iconCell.heightAnchor.constraint(equalTo: wrappCell.heightAnchor, multiplier: 0.70),
            
            arrowIcon.centerYAnchor.constraint(equalTo: wrappCell.centerYAnchor),
            arrowIcon.trailingAnchor.constraint(equalTo: wrappCell.trailingAnchor, constant: -16),
            arrowIcon.heightAnchor.constraint(equalToConstant: 17),
            arrowIcon.widthAnchor.constraint(equalToConstant: 10),
            
            titleCell.centerYAnchor.constraint(equalTo: wrappCell.centerYAnchor),
            titleCell.leadingAnchor.constraint(equalTo: iconCell.trailingAnchor, constant: 20),
            titleCell.trailingAnchor.constraint(equalTo: arrowIcon.leadingAnchor, constant: 20),
            titleCell.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }
}
