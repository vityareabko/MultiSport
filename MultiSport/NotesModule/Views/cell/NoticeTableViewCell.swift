//
//  NoticeTableViewCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 27/04/23.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {
    
    static let identifier = "NoticeTableViewCell"
    
    // MARK: - UI Components
    private let back: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBagroubdSubviews
        view.layer.cornerRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let noteTitle = UILabel(text: "NoteTitle", textColor: .systemGray5, font: .gothamBold15())
    let noteBody = UILabel(text: "West", textColor: .systemGray5, font: .gothamRegular15())
    
    private let editButton = UIButton(icon: UIImage(named: "editPencil") ?? UIImage())
    private let binButton = UIButton(icon: UIImage(named: "bin") ?? UIImage())
    
    private var stackViewTools = UIStackView()
    
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
        
        
        setStackView()
        noteBody.numberOfLines = 0
        noteBody.adjustsFontSizeToFitWidth = false
        noteBody.attributedText = NSAttributedString(string: noteBody.text!, attributes: [NSAttributedString.Key.baselineOffset: 4])
        
        self.contentView.addSubview(back)
        
        self.addSubview(back)
        back.addSubview(noteTitle)
        back.addSubview(noteBody)
        back.addSubview(stackViewTools)        
    }
    
    private func setStackView() {
        stackViewTools = UIStackView(arrangedSubviews: [editButton, binButton])
        stackViewTools.axis = .horizontal
        stackViewTools.spacing = 10
        stackViewTools.distribution = .equalSpacing
        stackViewTools.translatesAutoresizingMaskIntoConstraints = false
    }
}

    // MARK: - Extensions
extension NoticeTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            back.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            back.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            back.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            back.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            editButton.widthAnchor.constraint(equalToConstant: 20),
            editButton.heightAnchor.constraint(equalToConstant: 20),
            binButton.widthAnchor.constraint(equalToConstant: 20),
            binButton.heightAnchor.constraint(equalToConstant: 20),

            noteTitle.topAnchor.constraint(equalTo: back.topAnchor, constant: 20),
            noteTitle.leadingAnchor.constraint(equalTo: back.leadingAnchor, constant: 15),
            noteTitle.trailingAnchor.constraint(equalTo: back.trailingAnchor, constant: -15),
            noteTitle.heightAnchor.constraint(equalToConstant: 16),
            
            noteBody.topAnchor.constraint(equalTo: noteTitle.bottomAnchor, constant: 7),
            noteBody.leadingAnchor.constraint(equalTo: back.leadingAnchor, constant: 15),
            noteBody.trailingAnchor.constraint(equalTo: back.trailingAnchor, constant: -15),
            noteBody.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60),

            
              
            stackViewTools.bottomAnchor.constraint(equalTo: back.bottomAnchor, constant: -20),
            stackViewTools.leadingAnchor.constraint(equalTo: back.leadingAnchor, constant: 15),
            stackViewTools.trailingAnchor.constraint(equalTo: back.trailingAnchor, constant: -15),
            stackViewTools.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
