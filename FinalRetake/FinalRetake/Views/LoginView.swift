//
//  LoginView.swift
//  FinalRetake
//
//  Created by Maryann Yin on 6/7/18.
//  Copyright © 2018 Maryann Yin. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    lazy var logoImage: UIImageView = {
        let meatlyLogo = UIImageView()
        meatlyLogo.image = #imageLiteral(resourceName: "meatly_logo")
        meatlyLogo.contentMode = .scaleAspectFit
        return meatlyLogo
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        textField.placeholder = "Email..."
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.textColor = UIColor.black
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true // this helps to obscure the user's password with *******
        textField.textColor = UIColor.black
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: UIControlState.normal)
        button.setTitleColor(.blue, for: UIControlState.normal)
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: UIControlState.normal)
        button.setTitleColor(.blue, for: UIControlState.normal)
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupLogoImage()
        setupEmailTextField()
        setupPWTextField()
        setupLoginButton()
        setupRegisterButton()
    }
    
    private func setupLogoImage() {
        addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 35).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        logoImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
        logoImage.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setupEmailTextField() {
        addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 10).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    private func setupPWTextField() {
        addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    private func setupLoginButton() {
        addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        loginButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    private func setupRegisterButton() {
        addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        registerButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true
    }
    
}
