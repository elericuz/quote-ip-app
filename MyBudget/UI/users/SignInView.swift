//
//  SignInView.swift
//  MyBudget
//
//  Created by Eric Valera Miller on 24/07/24.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var userAuth: UserViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var isLogged: Bool = false
    @State private var showRoasterMessage = false
    
    var body: some View {
        ZStack {
            Color.backgroundLight.opacity(0.25).ignoresSafeArea()
            VStack {
                HeaderView()
                Spacer()
            }
            
            VStack {
                Group {
                    VStack(alignment: .leading) {
                        Text("Hola,")
                            .font(Font.custom("Poppins-Regular", size: Sizes.bigTitle))
                            .padding(.top, 64)
                        Text("¿cómo estás?")
                            .font(Font.custom("Poppins-Regular", size: Sizes.bigTitle))
                        Text("¿Hacemos un presupuesto?")
                            .font(Font.custom("Poppins-Regular", size: Sizes.subtitle))
                            .padding(.vertical)
                    }
                    .padding(32)
                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                }
                
                
                VStack(spacing: 16) {
                    Group {
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                Rectangle()
                                    .fill(.clear)
                                    .frame(width: 16, height: 16)
                                    .overlay(
                                        Image("badge")
                                            .resizable()
                                            .foregroundColor(.secondaryDark)
                                            .frame(width: Sizes.body, height: Sizes.body)
                                    )
                                Text("Usuario")
                                    .font(Font.custom("Poppins-Regular", size: Sizes.body))
                                    .foregroundColor(.secondaryDark)
                                    .padding(.leading, 4)
                            }.frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("Ingresa tu usuario", text: $email)
                                .textFieldStyle(CustomTextFieldStyle())
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                        }
                    }
                    
                    Group {
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                Rectangle()
                                    .fill(.clear)
                                    .frame(width: 16, height: 16)
                                    .overlay(
                                        Image("key")
                                            .resizable()
                                            .foregroundColor(.secondaryDark)
                                            .frame(width: Sizes.body, height: Sizes.body)
                                    )
                                Text("Password")
                                    .font(Font.custom("Poppins-Regular", size: Sizes.body))
                                    .foregroundColor(.secondaryDark)
                                    .padding(.leading, 4)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            SecureField("Ingresa tu password", text: $password)
                                .textFieldStyle(CustomTextFieldStyle())
                                .placeholderForPassword(
                                    Text("Ingrese password")
                                        .padding(.horizontal)
                                        .foregroundColor(.neutralLight)
                                        .font(Font.custom("Poppins-Regular", size: Sizes.placeholder)),
                                    alignment: .leading,
                                    isShowing: password.isEmpty
                                )
                            
                            NavigationLink {
                                ForgotPasswordView()
                            } label: {
                                Text("Olvidé mi password")
                                    .font(Font.custom("interTight", size: Sizes.placeholder))
                                    .foregroundColor(.secondaryDark)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.vertical, 4)
                            }
                        }
                    }
                    
                    Group {
                        VStack {
                            Button(action: {
                                userAuth.signInWithEmailAndPassword(email: email, password: password)
                            }) {
                                Text("Ingresar")
                                    .primaryButtonStyle()
                                    .shadow(color: .secondaryDark.opacity(0.6), radius: 10, x: 0, y: 4)
                            }
                            
                            HStack(spacing: 4) {
                                Text("¿No tienes una cuenta?")
                                NavigationLink {
                                    SignUpView()
                                } label: {
                                    Text("Regístrate aqui")
                                }

                            }
                            .font(Font.custom("interTight", size: Sizes.placeholder))
                            .foregroundColor(.secondaryDark)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.vertical, 4)
                        }
                        .padding(.vertical)
                    }
                    
                    Group {
                        HStack {
                            Image("line_h")
                                .resizable()
                                .foregroundColor(.primaryDark)
                                .frame(width: 52, height: 1)
                            Text("o también puedes")
                            Image("line_h")
                                .resizable()
                                .foregroundColor(.tertiaryDark)
                                .frame(width: 52, height: 1)
                        }
                        .padding(.vertical)
                        
                        Button(action: {
                            // Action for the sign in button
                            Task {
                                try await userAuth.signInWithGoogle()
                            }
                        }) {
                            HStack {
                                Image("google")
                                Text("Ingresar con Google")
                                    .font(Font.custom("Poppins-Regular", size: Sizes.primaryButtonText))
                                    .foregroundColor(.secondaryDark)
                            }
                            .frame(height: 52)
                            .frame(maxWidth: .infinity, minHeight: 52, maxHeight: 52)
                            .background(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.secondaryDark, lineWidth: 2)
                            )
                            .cornerRadius(8)
                            .shadow(color: .secondaryDark.opacity(0.2), radius: 5, x: 0, y: 4)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                .onChange(of: userAuth.error) { oldValue, newValue in
                    if (newValue) {
                        showRoasterMessage = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            showRoasterMessage = false
                        }
                    }
                }
                Spacer()
            }
            
            if showRoasterMessage {
                VStack {
                    Text(userAuth.errorMessage)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .transition(.opacity)
                .animation(.easeInOut, value: showRoasterMessage)
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct SignInView_Previews: PreviewProvider {
    @StateObject var userAuth = UserViewModel()
    
    static var previews: some View {
        NavigationStack {
            VStack {
                SignInView()
            }
            .environmentObject({ () -> UserViewModel in
                let envObj = UserViewModel()
                return envObj
            }())
        }
        .colorScheme(.light)
    }
}
