//
//  NoticeTableViewLastCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 27/04/23.
//

import UIKit

class NoticeTableViewLastCell: UITableViewCell {
    
    static let identifier = "NoticeTableViewLastCell"
    
    // MARK: - UI Components
    private let addNoteButton = UIButton(icon: UIImage(named: "addButton") ?? UIImage())
    private let addNoteLabel = UILabel(text: "ADD A NOTE", textColor: .specialOrangeColor, font: .gothamBold15())
    
    
    // MARK: - init
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
                
        self.contentView.addSubview(addNoteButton)
        self.addSubview(addNoteButton)
        self.addSubview(addNoteLabel)

    }
}

// MARK: - Extensions
extension NoticeTableViewLastCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            addNoteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            addNoteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addNoteButton.widthAnchor.constraint(equalToConstant: 72),
            addNoteButton.heightAnchor.constraint(equalToConstant: 72),
            
            addNoteLabel.topAnchor.constraint(equalTo: addNoteButton.bottomAnchor, constant: 20),
            addNoteLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addNoteLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100)
        ])
    }
}
