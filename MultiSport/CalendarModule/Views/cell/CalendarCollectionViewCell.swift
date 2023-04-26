//
//  CalendarCollectionViewCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 26/04/23.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CalendarCollectionViewCell"
    
    // MARK: - UI Components
    let label = UILabel(text: "", textColor: .systemGray5, font: .gothamRegular15())
    
    let back: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                label.textColor = .white
                back.backgroundColor = .specialOrangeColor
            } else {
                label.textColor = .systemGray5
                back.backgroundColor = .clear
            }
        }
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI() 
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.back.layer.cornerRadius = self.back.frame.width * 0.5

    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.backgroundColor = .clear
        label.textAlignment = .center
//        self.layer.cornerRadius = self.frame.width / 2
        
        self.addSubview(back)
        back.addSubview(label)
    }
}

// MARK: - Extensions
extension CalendarCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            back.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            back.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            back.widthAnchor.constraint(equalToConstant: 35),
            back.heightAnchor.constraint(equalToConstant: 35),
            
            label.centerXAnchor.constraint(equalTo: back.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: back.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 20),
            label.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
