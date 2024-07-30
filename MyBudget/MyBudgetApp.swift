//
//  MyBudgetApp.swift
//  MyBudget
//
//  Created by Eric Valera Miller on 23/07/24.
//

import SwiftUI
import Firebase

@main
struct MyBudgetApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State private var authController = AuthService()
    @StateObject var userAuth = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .colorScheme(.light)
            .environmentObject(userAuth)
            .environmentObject(authController)
            .onAppear {
                userAuth.listenToAuthState()
            }
        }
    }
}
