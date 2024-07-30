//
//  AuthService.swift
//  MyBudget
//
//  Created by Eric Valera Miller on 24/07/24.
//

import Foundation
import Firebase
import Combine

class AuthService: ObservableObject {
//    @Published var secondData = "SecondViewModel data"
    @Published var isLogged = false
    
//    init() {
//        self.isLogged = Auth.auth().currentUser?.isAnonymous ?? true
//        print(self.isLogged)
//    }
    
//    private var viewModel: UserViewModel
    
//    init(userViewModel: UserViewModel) {
//        self.viewModel = userViewModel
//    }
    
    func updateData() {
        print("hola")
    }
    
//    func signInWithEmailAndPassword(email: String, password: String) {
//        guard email.trimmingCharacters(in: .whitespacesAndNewlines).count >= 0 else {
//            return
//        }
//        
//        guard password.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 else {
//            return
//        }
//        
//        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
//            guard error == nil else {
//                return
//            }
//            
//            self.viewModel.userId = Auth.auth().currentUser?.uid
//            print(self.viewModel.userId!)
//            
//        }
//    }

}
