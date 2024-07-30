//
//  UserViewModel.swift
//  MyBudget
//
//  Created by Eric Valera Miller on 24/07/24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

class UserViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var userId: String?
    @Published var error: Bool = false
    @Published var errorMessage: String = ""
    @Published var userCreated: Bool = false
    @Published var passwordReseted: Bool = false
    @Published var displayName: String = ""
    
    init() {
        self.isLoggedIn = Auth.auth().currentUser != nil
    }
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            
            let isVerified = Auth.auth().currentUser?.isEmailVerified ?? false
            if isVerified {
                DispatchQueue.main.async {
                    if user != nil && ((user?.isEmailVerified) != nil) {
                        self.isLoggedIn = user != nil
                        self.userId = user?.uid
                    }
                }
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    func signInWithEmailAndPassword(email: String, password: String) {
        guard email.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 else {
            DispatchQueue.main.async {
                self.errorMessage = "El correo electrónico no es válido"
                self.error.toggle()
            }
            return
        }
        
        guard password.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 else {
            DispatchQueue.main.async {
                self.errorMessage = "El password no es válido"
                self.error.toggle()
            }
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    self.errorMessage = error?.localizedDescription ?? "Por favor vuelva a intentarlo"
                    self.error.toggle()
                }
                return
            }
            
            DispatchQueue.main.async {
                self.userId = Auth.auth().currentUser?.uid
                self.displayName = Auth.auth().currentUser?.displayName ?? ""
            }
        }
    }
    
    func signInWithGoogle() async throws {
        guard let rootViewController = await UIApplication.shared.firstKeyWindow?.rootViewController else { return }
        guard let clientId = FirebaseApp.app()?.options.clientID else { return }
        let configuration = GIDConfiguration(clientID: clientId)
        GIDSignIn.sharedInstance.configuration = configuration
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        guard let idToken = result.user.idToken?.tokenString else { return }
        let accessToken = result.user.accessToken.tokenString
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        if let currentUser = Auth.auth().currentUser {
            DispatchQueue.main.async {
                currentUser.link(with: credential) { authResult, error in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                        self.error.toggle()
                        return
                    }
                    
                    self.userId = Auth.auth().currentUser?.uid
                    self.isLoggedIn.toggle()
                }
            }
        } else {
            Task {
                try await Auth.auth().signIn(with: credential)
            }
            DispatchQueue.main.async {
                self.userId = Auth.auth().currentUser?.uid
                self.isLoggedIn.toggle()
            }
        }
        
        DispatchQueue.main.async {
            self.userId = Auth.auth().currentUser?.uid
            self.isLoggedIn = true
            self.displayName = Auth.auth().currentUser?.displayName ?? ""
        }
    }
    
    func signUpWithEmailAndPassword(name: String, lastname: String, email: String, password: String, confirmPassword: String) {
        guard password.trimmingCharacters(in: .whitespacesAndNewlines).count >= 8 else {
            DispatchQueue.main.async {
                self.errorMessage = "El password debe tener al menos 8 caracteres"
                self.error.toggle()
            }
            return
        }
        
        guard password == confirmPassword else {
            DispatchQueue.main.async {
                self.errorMessage = "Ambos passwords deben coincidir"
                self.error.toggle()
            }
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    self.errorMessage = error!.localizedDescription
                    self.error.toggle()
                }
                return
            }
            
            let user = Auth.auth().currentUser
            let changeRequest = user!.createProfileChangeRequest()
            changeRequest.displayName = "\(name) \(lastname)"
            
            changeRequest.commitChanges { error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.errorMessage = "Error al actualizar el nombre: \(error.localizedDescription)"
                        self.error.toggle()
                    }
                    return
                } else {
                    self.userId = Auth.auth().currentUser?.uid
                }
            }
            
            Auth.auth().currentUser?.sendEmailVerification { error in
                guard error == nil else {
                    DispatchQueue.main.async {
                        self.errorMessage = error!.localizedDescription
                        self.error.toggle()
                    }
                    return
                }
            }
            
            DispatchQueue.main.async {
                self.userCreated.toggle()
            }
        }
    }
    
    func forgotPassword(email: String) {
        guard email.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 else {
            DispatchQueue.main.async {
                self.errorMessage = "El correo electrónico no es válido"
                self.error.toggle()
            }
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard error == nil else {
                DispatchQueue.main.async {
                    self.errorMessage = error!.localizedDescription
                    self.error.toggle()
                }
                return
            }
        }
        
        DispatchQueue.main.async {
            self.passwordReseted.toggle()
        }
    }
}

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap{$0 as? UIWindowScene}
            .filter { $0.activationState == .foregroundActive }
            .first?.windows
            .first(where: \.isKeyWindow)
    }
}
