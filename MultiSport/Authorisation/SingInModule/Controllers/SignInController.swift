//
//  LoginController.swift
//  MultiSport
//
//  Created by Витя Рябко on 04/04/23.
//

import UIKit

class SignInController: UIViewController {
    
    // MARK: - UI Components
    private let titleLabelController = UILabel(text: "SING IN", textColor: .specialOrangeColor, font: .gothamBold22())
    private let subTitleText = UILabel(text: "Don’t have an account?", textColor: .systemGray5, font: .gothamRegular18())
    private let emailLabel = UILabel(text: "E-mail", textColor: .systemGray5, font: .gothamBold18())
    private let passwordLabel = UILabel(text: "Password", textColor: .systemGray5, font: .gothamBold18())
    private let emailTextField = UITextField(placeholder: "Type your e-mail")
    private let passwordTextField = UITextField(placeholder: "Type your password")
    private let buttonLink = UIButton(text: "Sign Up", textColor: .specialOrangeColor, font: .gothamBold18())
    private let signInButton = UIButton(text: "Sing In", textColor: .specialMainBaground, bgColor: .specialOrangeColor, font: .gothamBold15())
    private let forgetPassworButton = UIButton(text: "Forgot your password?", textColor: .systemGray3, font: .gothamLight18())
    private var emailStackView = UIStackView()
    private var passStackView = UIStackView()
    
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
        
        buttonLink.addTarget(self, action: #selector(didTappedSingUpButton), for: .touchUpInside)
        
        setStackView()
        passwordTextField.isSecureTextEntry = true
        emailTextField.keyboardType = .emailAddress
        
        self.view.addSubview(titleLabelController)
        self.view.addSubview(subTitleText)
        self.view.addSubview(buttonLink)
        self.view.addSubview(emailStackView)
        self.view.addSubview(passStackView)
        self.view.addSubview(signInButton)
        self.view.addSubview(forgetPassworButton)
    }
    
    private func setStackView() {
        emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        emailStackView.axis = .vertical
        emailStackView.spacing = 15
        emailStackView.distribution = .equalSpacing
        
        passStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        passStackView.axis = .vertical
        passStackView.spacing = 15
        passStackView.distribution = .equalSpacing
        
        emailStackView.translatesAutoresizingMaskIntoConstraints = false
        passStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: - selectors
    @objc private func didTappedSingUpButton() {
        if navigationController?.viewControllers.last(where: { $0 !== self }) is MainViewController {
            let vc = SignUpController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - UITextFieldDelegate
extension SignInController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

// MARK: - Constraints
extension SignInController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabelController.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabelController.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabelController.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            titleLabelController.heightAnchor.constraint(equalToConstant: 25),
            
            subTitleText.topAnchor.constraint(equalTo: titleLabelController.bottomAnchor, constant: 25),
            subTitleText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            subTitleText.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            buttonLink.topAnchor.constraint(equalTo: subTitleText.topAnchor, constant: -2),
            buttonLink.leadingAnchor.constraint(equalTo: subTitleText.trailingAnchor, constant: 10),
            buttonLink.heightAnchor.constraint(equalToConstant: 20),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -130),
            emailStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            emailStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            emailStackView.heightAnchor.constraint(equalToConstant: 80),
            
            passStackView.topAnchor.constraint(equalTo: emailStackView.bottomAnchor, constant: 30),
            passStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            passStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            passStackView.heightAnchor.constraint(equalToConstant: 80),
            
            signInButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -200),
            signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            signInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            
            forgetPassworButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 10),
            forgetPassworButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            forgetPassworButton.heightAnchor.constraint(equalToConstant: 20),
            forgetPassworButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),

        ])
    }
}
