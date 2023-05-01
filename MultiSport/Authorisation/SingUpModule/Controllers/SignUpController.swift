//
//  SignUpController.swift
//  MultiSport
//
//  Created by Витя Рябко on 01/05/23.
//

import UIKit

class SignUpController: UIViewController {
    
    private let titleLabelController = UILabel(text: "SING UP", textColor: .specialOrangeColor, font: .gothamBold22())
    private let subTitleText = UILabel(text: "Have an account?", textColor: .systemGray5, font: .gothamRegular18())
    
    private let loginLabel = UILabel(text: "Login", textColor: .systemGray5, font: .gothamRegular18())
    private let passwordLabel = UILabel(text: "Password", textColor: .systemGray5, font: .gothamRegular18())
    private let emailLabel = UILabel(text: "E-mail", textColor: .systemGray5, font: .gothamRegular18())
    private let wordVereficLabel = UILabel(text: "Word for verifying", textColor: .systemGray5, font: .gothamRegular18())
    
    private let loginTextField = UITextField(placeholder: "Type your login")
    private let passwordTextField = UITextField(placeholder: "Type your password")
    private let emailTextField = UITextField(placeholder: "Type your e-mail")
    private let wordVerifcTextField = UITextField(placeholder: "Type your word for verifying")
    
    
    private let buttonLink = UIButton(text: "Log In", textColor: .specialOrangeColor, font: .gothamBold18())
    private let signUpButton = UIButton(text: "CREATE AN ACCOUNT", textColor: .specialMainBaground, bgColor: .specialOrangeColor, font: .gothamBold15())
    
    private var singUpStackView = UIStackView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setDelegate()
        setConstraints()
        setNavigationBar()
        setupGestureRecognizer()
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .specialMainBaground

        setStackView()
        
        self.view.addSubview(titleLabelController)
        self.view.addSubview(subTitleText)
        self.view.addSubview(buttonLink)
        self.view.addSubview(singUpStackView)
        self.view.addSubview(signUpButton)
    }
    
    // MARK: - setStackView
    private func setStackView() {
        let loginStackView = UIStackView(arrangedSubviews: [loginLabel, loginTextField])
        loginStackView.axis = .vertical
        loginStackView.spacing = 15
        loginStackView.distribution = .equalSpacing
    
        let passStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        passStackView.axis = .vertical
        passStackView.spacing = 15
        passStackView.distribution = .equalSpacing
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        emailStackView.axis = .vertical
        emailStackView.spacing = 15
        emailStackView.distribution = .equalSpacing
        
        let wordVerificStackView = UIStackView(arrangedSubviews: [wordVereficLabel, wordVerifcTextField])
        wordVerificStackView.axis = .vertical
        wordVerificStackView.spacing = 15
        wordVerificStackView.distribution = .equalSpacing
        
        
        singUpStackView = UIStackView(arrangedSubviews: [loginStackView, passStackView,
                                                 emailStackView, wordVerificStackView])
        
        singUpStackView.axis = .vertical
        singUpStackView.spacing = 30
        singUpStackView.distribution = .equalSpacing
        singUpStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegate() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
        wordVerifcTextField.delegate = self
    }
}

// MARK: - UITextFieldDelegate
extension SignUpController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}


// MARK: - Constraints
extension SignUpController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabelController.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabelController.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabelController.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            titleLabelController.heightAnchor.constraint(equalToConstant: 25),
            
            subTitleText.topAnchor.constraint(equalTo: titleLabelController.bottomAnchor, constant: 25),
            subTitleText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            subTitleText.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            buttonLink.topAnchor.constraint(equalTo: titleLabelController.bottomAnchor, constant: 23),
            buttonLink.leadingAnchor.constraint(equalTo: subTitleText.trailingAnchor, constant: 10),
            buttonLink.heightAnchor.constraint(equalToConstant: 20),
            
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            wordVerifcTextField.heightAnchor.constraint(equalToConstant: 50),
            
            singUpStackView.topAnchor.constraint(equalTo: buttonLink.bottomAnchor, constant: 40),
            singUpStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            singUpStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            singUpStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            
            signUpButton.topAnchor.constraint(equalTo: singUpStackView.bottomAnchor, constant: 30),
            signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
    }
}
