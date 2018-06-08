//
//  LoginViewController.swift
//  FinalRetake
//
//  Created by Maryann Yin on 6/7/18.
//  Copyright © 2018 Maryann Yin. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let firebaseAuthService = FirebaseAuthService()
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseAuthService.delegate = self
        view.addSubview(loginView)
        setTextFieldsDelegates()
        setupActionButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardAdjusted == false {
            lastKeyboardOffset = getKeyboardHeight(notification: notification)
            view.frame.origin.y -= lastKeyboardOffset
            keyboardAdjusted = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardAdjusted == true {
            view.frame.origin.y += lastKeyboardOffset
            keyboardAdjusted = false
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    private func setTextFieldsDelegates() {
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
    }
    
    func setupActionButtons() {
        loginView.loginButton.addTarget(self, action: #selector(signIn), for: UIControlEvents.touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(register), for: UIControlEvents.touchUpInside)
    }
    
    @objc func signIn() {
        view.endEditing(true)
        guard let passwordText = loginView.passwordTextField.text else {
            showAlert(title: "Login Failed", message: "Please enter your password.")
            return
        }
        guard !passwordText.isEmpty else {
            showAlert(title: "Login Failed", message: "Password field is empty.")
            return
        }
        firebaseAuthService.signIn(email: loginView.emailTextField.text!, password: passwordText)
    }
    
    @objc func register() {
        view.endEditing(true)
        print("Register button has been pressed.")
        guard let emailText = loginView.emailTextField.text else {
            showAlert(title: "Registration Failed", message: "Please enter a valid email address.")
            return
        }
        guard !emailText.isEmpty else {
            showAlert(title: "Registration Failed", message: "Please enter a valid email address.")
            return
        }
        guard let passwordText = loginView.passwordTextField.text else {
            showAlert(title: "Registration Failed", message: "Please enter a valid password.")
            return
        }
        guard !passwordText.isEmpty else {
            showAlert(title: "Registration Failed", message: "Please enter a valid password.")
            return
        }
        firebaseAuthService.createUser(email: emailText, password: passwordText)
    }
    
    private func clearLoginTextFields() {
        loginView.emailTextField.text = ""
        loginView.passwordTextField.text = ""
    }
    
}

extension LoginViewController: FirebaseAuthServiceDelegate {
    
    func didCreateUser(_authService: FirebaseAuthService, user: User) {
        FirebaseAuthService.getCurrentUser()!.sendEmailVerification(completion: {(error) in
            if let error = error {
                print("Error sending message verification \(error).")
                self.showAlert(title: "Error", message: "Error sending verification email.")
                self.firebaseAuthService.signOut()
            } else {
                self.showAlert(title: "Verification Sent", message: "Please verify email.")
                self.clearLoginTextFields()
            }
        })
    }
    
    func didFailCreatingUser(_authService: FirebaseAuthService, error: Error) {
        showAlert(title: "Sign Up Failed", message: error.localizedDescription)
    }
    
    func didSignIn(_authService: FirebaseAuthService, user: User) {
        if FirebaseAuthService.getCurrentUser()!.isEmailVerified {
            let signInAlertController = UIAlertController(title: "Login Successful", message: nil, preferredStyle: .alert)
            let continueAction = UIAlertAction(title: "Continue", style: .default) {alert in
                self.dismiss(animated: true, completion: nil)
            }
            signInAlertController.addAction(continueAction)
            present(signInAlertController, animated: true, completion: nil)
        } else {
            showAlert(title: "Email Verification Needed", message: "Please verify email.")
            firebaseAuthService.signOut()
        }
    }
    
    func didFailSignIn(_authService: FirebaseAuthService, error: Error) {
        showAlert(title: "Login Failed", message: error.localizedDescription)
    }
    
    func didResetPassword(_authService: FirebaseAuthService, user: User) {
        showAlert(title: "Password Reset", message: "Email for password reset sent.")
    }
    
    func didFailResetPassword(_authService: FirebaseAuthService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
