//
//  ForgotPasswordView.swift
//  MyBudget
//
//  Created by Eric Valera Miller on 24/07/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var userAuth: UserViewModel
    
    @State private var email: String = ""
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
                        Text("¿Olvidaste tu Password?")
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
                        Text("Tranquilo, a cualquiera le puede pasar. Solo escribe tu correo electrónico y te mandaremos las instrucciones para puedas volver a ingresar.")
                            .font(Font.custom("InterTight", size: Sizes.body))
                            .foregroundColor(.secondaryDark)
                            .multilineTextAlignment(.leading)
                        
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
                                    .keyboardType(.alphabet)
                            }
                        }
                        
                        Group {
                            VStack {
                                Button(action: {
                                    userAuth.forgotPassword(email: email)
                                }) {
                                    Text("Enviar")
                                        .primaryButtonStyle()
                                        .shadow(color: .secondaryDark.opacity(0.6), radius: 10, x: 0, y: 4)
                                }
                            }
                            .padding(.vertical)
                            .onChange(of: userAuth.passwordReseted, { _, _ in
                                self.showConfirmation.toggle()
                            })
                            .sheet(isPresented: $showConfirmation) {
                                presentationMode.wrappedValue.dismiss()
                            } content: {
                                VStack(spacing: 8) {
                                    Text("¡Solicitud Enviada!")
                                        .font(Font.custom("Roboto-Regular", size: Sizes.subtitle))
                                    Text("Te acabamos de enviar un correo eletrónico con las instrucciones para cambiar tu password. Búscalo en tu bandeja de entrada y vuelve enseguida para poder continuar.")
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
                }
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    @StateObject var userAuth = UserViewModel()
    
    static var previews: some View {
        NavigationStack {
            VStack {
                ForgotPasswordView()
            }
            .environmentObject({ () -> UserViewModel in
                let envObj = UserViewModel()
                return envObj
            }())
        }
        .colorScheme(.light)
    }
}
