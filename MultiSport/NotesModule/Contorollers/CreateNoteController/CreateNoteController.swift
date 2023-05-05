//
//  CreateNoteController.swift
//  MultiSport
//
//  Created by Витя Рябко on 28/04/23.
//

import UIKit

class CreateNoteController: UIViewController {
    
    // MARK: - Variables
    public var editController = false
    public var model: Notice?
    
    // MARK: - UI Components
    private let titleLabelController = UILabel(text: "", textColor: .specialOrangeColor, font: .gothamBold22())
    private let titleNoteTextField = UITextField(placeholder: "Title")
    
    private let textViewNote = UITextView(placeholder: "Type your text here")
    
    private lazy var buttonSubmit = UIButton(text: "", textColor: .specialMainBaground, bgColor: .specialOrangeColor, font: .gothamBold15())
    
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
        
        titleLabelController.text = editController ? "EDIT NOTE" : "CREATE A NOTE"
        buttonSubmit.setTitle(editController ? "EDIT NOTE" : "CREATE A NOTE", for: .normal)
        
        buttonSubmit.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        
        self.view.addSubview(titleLabelController)
        self.view.addSubview(titleNoteTextField)
        self.view.addSubview(textViewNote)
        self.view.addSubview(buttonSubmit)
    
    }
    
    private func observersForKeyboardTextView() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setDelegate() {
        titleNoteTextField.delegate = self
    }
    
    public func setData() {
        if let model = self.model {
            titleNoteTextField.text = model.noticetitle
            textViewNote.text = model.noticebody
        }
    }
    
    @objc private func updateTextView(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any],
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        // Вычисляем высоту экрана.
        let screenHeight = UIScreen.main.bounds.height
        
        // Вычисляем новую высоту контроллера.
        let newControllerHeight = screenHeight - keyboardFrame.height
        
        // Создаем анимацию изменения высоты контроллера.
        UIView.animate(withDuration: 0.9) {
            // Устанавливаем новую высоту контроллера.
            self.view.frame.size.height = newControllerHeight
        }
    
    }
    
    @objc private func hideKeyboard() {
        // Создаем анимацию изменения высоты контроллера.
        UIView.animate(withDuration: 0.9) {
            // Устанавливаем исходную высоту контроллера.
            self.view.frame.size.height = UIScreen.main.bounds.height
        }
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
        
        if editController {
            if let model = self.model {
                CoreDataManager.shared.updateObject(object: model) {
                    model.noticetitle = titleNoteTextField.text
                    model.noticebody = textViewNote.text
                }
            }
        } else {
            let newNotice = CoreDataManager.shared.createObject(entity: Notice.self)
            newNotice.createdAt = Date()
            newNotice.updatedAt = Date()
            newNotice.idUser = 0
            newNotice.noticetitle = self.titleNoteTextField.text
            newNotice.noticebody = self.textViewNote.text
            
            CoreDataManager.shared.saveObject(object: newNotice)
        }
        
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
            textViewNote.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4),
     
            buttonSubmit.topAnchor.constraint(equalTo: textViewNote.bottomAnchor, constant: 20),
            buttonSubmit.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            buttonSubmit.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonSubmit.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
}
