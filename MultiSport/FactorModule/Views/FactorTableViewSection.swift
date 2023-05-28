//
//  FactorTableViewSection.swift
//  MultiSport
//
//  Created by Витя Рябко on 20/05/23.
//

import UIKit

protocol TapToggleSectionProtocol: AnyObject {
    func showContent(index: Int)
}

class FactorTableViewSection: UIView {
    
    // MARK: - Variables
    var sectionID: Int = 999
    weak var tapToggleSectionDelegate: TapToggleSectionProtocol?
    var isFlipped = false
    
    
    // MARK: - UI Components
    private let labelName = UILabel(text: "GOLDEN BOOKMAKER", textColor: .systemGray5, font: .gothamBold15())
    
    private let logo = UIImageView(imageName: "factor1")
    private let toggleButton = UIButton(icon: UIImage(named: "orangeToggleArrow") ?? UIImage())
    
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBagroubdSubviews
        view.layer.cornerRadius = 7
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
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // Обновление состояния кнопки
        if self.isFlipped {
            toggleButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        } else {
            toggleButton.transform = CGAffineTransform.identity
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.backgroundColor = .specialMainBaground
        
        toggleButton.addTarget(self, action: #selector(didTappedTogglebutton), for: .touchUpInside)

        self.addSubview(backView)
        backView.addSubview(labelName)
        backView.addSubview(logo)
        backView.addSubview(toggleButton)
    }

    
    // MARK: - Selectors
    @objc func didTappedTogglebutton() {
        UIView.animate(withDuration: 0.3) {
            self.isFlipped.toggle()
            if self.isFlipped {
                self.toggleButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            } else {
                self.toggleButton.transform = CGAffineTransform.identity
            }
        }
        tapToggleSectionDelegate?.showContent(index: sectionID)
    }   
}

// MARK: - Constrains
extension FactorTableViewSection {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topAnchor),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            logo.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            logo.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15),
            logo.widthAnchor.constraint(equalToConstant: 50),
            logo.heightAnchor.constraint(equalToConstant: 50),
            
            labelName.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            labelName.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 20),
            labelName.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -43),
            
            toggleButton.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            toggleButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20),
            toggleButton.widthAnchor.constraint(equalToConstant: 20),
            toggleButton.heightAnchor.constraint(equalToConstant: 13),
   
        ])
    }
}

