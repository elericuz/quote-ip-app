//
//  SignUpView.swift
//  MyBudget
//
//  Created by Eric Valera Miller on 24/07/24.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var userAuth: UserViewModel
    
    @State private var name: String = ""
    @State private var lastname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword = ""
    @State private var showConfirmation: Bool = false
    
    var body: some View {
        ZStack {
            Color.backgroundLight.opacity(0.25)
            VStack {
                HeaderView()
                Spacer()
            }
            VStack {
                Group {
                    VStack(alignment: .leading) {
                        Text("Crea una cuenta nueva")
                            .font(Font.custom("Poppins-Regular", size: Sizes.bigTitle))
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .padding(.top, 64)
                    }
                    .padding(32)
                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                }
                
                ScrollView {
                    VStack(spacing: 16) {
                        Group {
                            VStack(spacing: 0) {
                                HStack(spacing: 0) {
                                    Rectangle()
                                        .fill(.clear)
                                        .frame(width: 16, height: 16)
                                        .overlay(
                                            Image("person")
                                                .resizable()
                                                .foregroundColor(.secondaryDark)
                                                .frame(width: Sizes.body, height: Sizes.body)
                                        )
                                    Text("Nombre")
                                        .font(Font.custom("Poppins-Regular", size: Sizes.body))
                                        .foregroundColor(.secondaryDark)
                                        .padding(.leading, 4)
                                }.frame(maxWidth: .infinity, alignment: .leading)
                                
                                TextField("Ingresa tu nombre", text: $name)
                                    .textFieldStyle(CustomTextFieldStyle())
                                    .keyboardType(.alphabet)
                            }
                        }
                        
                        Group {
                            VStack(spacing: 0) {
                                HStack(spacing: 0) {
                                    Rectangle()
                                        .fill(.clear)
                                        .frame(width: 16, height: 16)
                                        .overlay(
                                            Image("person")
                                                .resizable()
                                                .foregroundColor(.secondaryDark)
                                                .frame(width: Sizes.body, height: Sizes.body)
                                        )
                                    Text("Apellidos")
                                        .font(Font.custom("Poppins-Regular", size: Sizes.body))
                                        .foregroundColor(.secondaryDark)
                                        .padding(.leading, 4)
                                }.frame(maxWidth: .infinity, alignment: .leading)
                                
                                TextField("Ingresa tus apellidos", text: $lastname)
                                    .textFieldStyle(CustomTextFieldStyle())
                                    .keyboardType(.alphabet)
                            }
                        }
                        
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
                                    Text("Correo electrónico")
                                        .font(Font.custom("Poppins-Regular", size: Sizes.body))
                                        .foregroundColor(.secondaryDark)
                                        .padding(.leading, 4)
                                }.frame(maxWidth: .infinity, alignment: .leading)
                                
                                TextField("Ingresa tu correo electrónico", text: $email)
                                    .textFieldStyle(CustomTextFieldStyle())
                                    .autocapitalization(.none)
                                    .keyboardType(.alphabet)
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
                                    Text("Confirma el Password")
                                        .font(Font.custom("Poppins-Regular", size: Sizes.body))
                                        .foregroundColor(.secondaryDark)
                                        .padding(.leading, 4)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                SecureField("Vuelve a escribir tu password", text: $confirmPassword)
                                    .textFieldStyle(CustomTextFieldStyle())
                                    .placeholderForPassword(
                                        Text("Ingrese password")
                                            .padding(.horizontal)
                                            .foregroundColor(.neutralLight)
                                            .font(Font.custom("Poppins-Regular", size: Sizes.placeholder)),
                                        alignment: .leading,
                                        isShowing: password.isEmpty
                                    )
                            }
                        }
                        
                        Group {
                            VStack {
                                Button(action: {
                                    // Button action here
                                    userAuth.signUpWithEmailAndPassword(name: name, lastname: lastname, email: email, password: password, confirmPassword: confirmPassword)
                                }) {
                                    Text("Registrar")
                                        .primaryButtonStyle()
                                        .shadow(color: .secondaryDark.opacity(0.6), radius: 10, x: 0, y: 4)
                                }
                            }
                            .padding(.vertical)
                            .onChange(of: userAuth.userCreated, { _, _ in
                                self.showConfirmation.toggle()
                            })
                            .sheet(isPresented: $showConfirmation) {
                                presentationMode.wrappedValue.dismiss()
                            } content: {
                                VStack(spacing: 8) {
                                    Text("¡Ya tienes un usuario!")
                                        .font(Font.custom("Roboto-Regular", size: Sizes.subtitle))
                                    Text("Pero antes, te hemos enviado un correo de verificación a la dirección de correo eletrónico que escribiste. Por favor revísalo y sigue las instrucciones antes de poder continuar.")
                                        .font(Font.custom("Roboto-Regular", size: Sizes.body))
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(20)
                                .frame(width: UIScreen.main.bounds.width, height: 300)
                                .background(.white)
                                .foregroundColor(.secondaryDark)
                                .presentationDetents([.height(200)])
                            }

                        }
                    }
                    .padding(.horizontal, 24)
                    Spacer()
                }
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct SignUpView_Previews: PreviewProvider {
    @StateObject var userAuth = UserViewModel()
    
    static var previews: some View {
        NavigationStack {
            VStack {
                SignUpView()
            }
            .environmentObject({ () -> UserViewModel in
                let envObj = UserViewModel()
                return envObj
            }())
        }
        .colorScheme(.light)
    }
}
