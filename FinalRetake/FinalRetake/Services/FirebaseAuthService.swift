//
//  FirebaseAuthService.swift
//  FinalRetake
//
//  Created by Maryann Yin on 6/7/18.
//  Copyright © 2018 Maryann Yin. All rights reserved.
//

import Foundation
import FirebaseAuth

@objc protocol FirebaseAuthServiceDelegate: class {
    
    @objc optional func didFailCreatingUser(_authService: FirebaseAuthService, error: Error)
    @objc optional func didCreateUser(_authService: FirebaseAuthService, user: User)
    
    @objc optional func didFailSignIn(_authService: FirebaseAuthService, error: Error)
    @objc optional func didSignIn(_authService: FirebaseAuthService, user: User)
    
    @objc optional func didFailSignOut(_authService: FirebaseAuthService, error: Error)
    @objc optional func didSignOut(_authService: FirebaseAuthService, user: User)
    
    @objc optional func didFailResetPassword(_authService: FirebaseAuthService, error: Error)
    @objc optional func didResetPassword(_authService: FirebaseAuthService, user: User)
    
}

class FirebaseAuthService: NSObject {
    
    weak var delegate: FirebaseAuthServiceDelegate?
    
    public static func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    public func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password){(user, error) in
            if let error = error {
                self.delegate?.didFailCreatingUser?(_authService: self, error: error)
            } else if let user = user {
                let changeRequest = user.createProfileChangeRequest()
                let stringArray = user.email!.components(separatedBy: "@")
                let username = stringArray[0]
                changeRequest.displayName = username
                changeRequest.commitChanges(completion: {(error) in
                    if let error = error {
                        print("changeRequest error: \(error)")
                    } else {
                        self.delegate?.didCreateUser?(_authService: self, user: user)
                    }
                })
            }
        }
    }
    
    
    public func resetPassword(with email: String) {
        Auth.auth().sendPasswordReset(withEmail: email){(error) in
            if let error = error {
                self.delegate?.didFailResetPassword?(_authService: self, error: error)
                return
            }
            self.delegate?.didFailResetPassword?(_authService: self, error: error!)
        }
    }
    
    public func signOut() {
        do {
            try Auth.auth().signOut()
            delegate?.didSignOut?(_authService: self, user: Auth.auth().currentUser!)
            print("Successfully signed out")
        } catch {
            delegate?.didFailSignOut?(_authService: self, error: error)
        }
    }
    
    public func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {(user, error) in
            if let error = error {
                self.delegate?.didFailSignIn?(_authService: self, error: error)
            } else if let user = user {
                self.delegate?.didSignIn?(_authService: self, user: user)
            }
        }
    }
    
}
