//
//  ContentView.swift
//  MyBudget
//
//  Created by Eric Valera Miller on 23/07/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userAuth: UserViewModel
    @EnvironmentObject var authController: AuthService
    
    var body: some View {
        VStack {
            if userAuth.isLoggedIn {
                BudgetListingView()
            } else {
                SignInView()
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject var userAuth = UserViewModel()
    
    static var previews: some View {
        NavigationStack {
            VStack {
                ContentView()
            }
            .environmentObject({ () -> UserViewModel in
                let envObj = UserViewModel()
                return envObj
            }())
        }
        .colorScheme(.light)
    }
}
