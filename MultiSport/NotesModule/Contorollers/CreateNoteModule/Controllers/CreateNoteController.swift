//
//  CreateNoteController.swift
//  MultiSport
//
//  Created by Витя Рябко on 28/04/23.
//

import UIKit

class CreateNoteController: UIViewController {
    
    // MARK: - UI Components
    private let titleLabelController = UILabel(text: "CREATE A NOTE", textColor: .specialOrangeColor, font: .gothamBold22())
    private let titleNoteTextField = UITextField(placeholder: "Title")
    
    private let textViewNote = UITextView(placeholder: "Type your text here")
    
    private lazy var buttonSubmit = UIButton(text: "CREATE A NOTE", textColor: .specialMainBaground, bgColor: .specialOrangeColor, font: .gothamBold15())

    private var bottomDynamicConstraint: NSLayoutConstraint?
    private var heightDynamicConstraint: NSLayoutConstraint?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
        setDelegate()
        setNavigationBar()
        setupGestureRecognizer()
        
        observersForKeyboardTextView()
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .specialMainBaground
        
        buttonSubmit.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        
        self.view.addSubview(titleLabelController)
        self.view.addSubview(titleNoteTextField)
        self.view.addSubview(textViewNote)
        self.view.addSubview(buttonSubmit)
    
    }
    
    private func observersForKeyboardTextView() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setDelegate() {
        titleNoteTextField.delegate = self
    }
    
    @objc private func updateTextView(notification: Notification) {
        
        guard let userInfo = notification.userInfo as? [String: Any],
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            bottomDynamicConstraint?.isActive = false
            
            heightDynamicConstraint = textViewNote.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
            heightDynamicConstraint?.isActive = true
            textViewNote.contentInset = .zero
        } else {
            heightDynamicConstraint?.isActive = false
            
            bottomDynamicConstraint = textViewNote.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -keyboardFrame.height - 90)
            bottomDynamicConstraint?.isActive = true
            
            textViewNote.contentInset = UIEdgeInsets(top: 0, left: 7, bottom: 0 , right: 17)
            textViewNote.scrollIndicatorInsets = textViewNote.contentInset
        }
        
        textViewNote.scrollRangeToVisible(textViewNote.selectedRange)
        
    }
    
    @objc private func didTapSubmitButton() {
        if titleNoteTextField.text == "" {
            titleNoteTextField.shake(horizontal: 8)
            return
        }

        if textViewNote.text == "" {
            textViewNote.shake(horizontal: 8)
            return
        }
    
        let newNotice = CoreDataManager.shared.createObject(entity: Notice.self)
        newNotice.createdAt = Date()
        newNotice.updatedAt = Date()
        newNotice.idUser = 0
        newNotice.noticetitle = self.titleNoteTextField.text
        newNotice.noticebody = self.textViewNote.text

        CoreDataManager.shared.saveContext()
        navigationController?.popViewController(animated: true)
    }
}

extension CreateNoteController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

// MARK: - Extensions
extension CreateNoteController {
    private func setConstraints() {
        
        heightDynamicConstraint = textViewNote.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
        heightDynamicConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            titleLabelController.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabelController.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabelController.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            titleLabelController.heightAnchor.constraint(equalToConstant: 25),
            
            titleNoteTextField.topAnchor.constraint(equalTo: titleLabelController.bottomAnchor, constant: 20),
            titleNoteTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleNoteTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            titleNoteTextField.heightAnchor.constraint(equalToConstant: 52),
            
            textViewNote.topAnchor.constraint(equalTo: titleNoteTextField.bottomAnchor, constant: 20),
            textViewNote.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            textViewNote.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            buttonSubmit.topAnchor.constraint(equalTo: textViewNote.bottomAnchor, constant: 20),
            buttonSubmit.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            buttonSubmit.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonSubmit.heightAnchor.constraint(equalToConstant: 55),
            
        ])
    }
}
