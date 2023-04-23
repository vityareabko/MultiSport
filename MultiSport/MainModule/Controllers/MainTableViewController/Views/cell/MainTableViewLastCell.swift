//
//  MainTableViewLastCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 06/04/23.
//

import UIKit

class MainTableViewLastCell: UITableViewCell {
    
    static let identifier = "MainTableViewLastCell"
    
    public var closureScrollToUp: (() -> Void)?
    
    // MARK: - UI Components
    private lazy var buttonIcon: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "arrow.up")?.withTintColor(UIColor.systemGray2, renderingMode: .alwaysOriginal)
        button.contentMode = .scaleAspectFit
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapScollUp), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
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
        self.addSubview(buttonIcon)
        
        self.contentView.addSubview(buttonIcon)
    }
    
    // MARK: - Selectors
    @objc private func didTapScollUp() {
        guard let closure = closureScrollToUp else { return }
        closure()
    }
}

extension MainTableViewLastCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            buttonIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            buttonIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonIcon.widthAnchor.constraint(equalToConstant: 24),
            buttonIcon.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
