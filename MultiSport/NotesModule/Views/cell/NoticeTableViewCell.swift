//
//  NoticeTableViewCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 27/04/23.
//

import UIKit
// TODO: - переделать как в макете
class NoticeTableViewCell: UITableViewCell {
    
    static let identifier = "NoticeTableViewCell"
    
    var idModel = 0
    var reloadTableData: (() -> Void)?
    
    // MARK: - UI Components
    private let back: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBagroubdSubviews
        view.layer.cornerRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let noteTitle = UILabel(text: "NoteTitle", textColor: .systemGray5, font: .gothamBold15())
    let noteBody = UILabel(text: "West Brom ruthlessly exposed the 70-place gap between themselves.", textColor: .systemGray5, font: .gothamRegular15())
    let editButton = UIButton(icon: UIImage(named: "editPencil") ?? UIImage())
    let binButton = UIButton(icon: UIImage(named: "bin") ?? UIImage())
    
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
    
    public func setData(model: Notice) {
        self.noteTitle.text = model.noticetitle
        self.noteBody.text = model.noticebody
    }
}

    // MARK: - Extensions
extension NoticeTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            
            back.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            back.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            back.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            back.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            editButton.widthAnchor.constraint(equalToConstant: 20),
            binButton.widthAnchor.constraint(equalToConstant: 20),

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
