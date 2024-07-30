//
//  BudgetListingView.swift
//  MyBudget
//
//  Created by Eric Valera Miller on 24/07/24.
//

import SwiftUI

struct BudgetListingView: View {
    @EnvironmentObject var userAuth: UserViewModel
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                HeaderView()
                Spacer()
            }
            VStack {
                Group {
                    VStack(alignment: .leading, spacing: 8) {
                        Spacer()
                        HStack(spacing: 8) {
                            Circle()
                                .fill(.white)
                                .frame(width: 40)
                                .overlay(
                                    Image("person")
                                        .resizable()
                                        .foregroundColor(.secondaryDark)
                                        .frame(width: 24, height: 24)
                                )
                                .shadow(color: .secondaryDark, radius: 25, x: 0, y: 0)
                            Text("Mis Presupuestos")
                                .font(Font.custom("Poppins-Regular", size: Sizes.title))
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                        }
                        .frame(height: 48)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 64)
                        .padding(.horizontal, 24)
                        
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 8) {
                                ForEach(budgetList) { budget in
                                    BudgetItemView(budget: budget)
                                    Image("line_h")
                                        .resizable()
                                        .foregroundColor(.secondaryDark)
                                        .frame(height: 1)
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal, 24)
                                }
                            }
                        }
                    }
                }
                
                Spacer()

                VStack {
                    HStack(spacing: 16) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.clear)
                            .stroke(.white, lineWidth: 1)
                            .frame(width: 48, height: 48)
                            .overlay(
                                Button(action: {
                                    //
                                }, label: {
                                    VStack(spacing: 0) {
                                        Image("tune")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(.white)
                                        Text("Ajustes")
                                            .font(Font.custom("InterTight", size: Sizes.caption))
                                    }
                                })
                            )
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.neutralLight)
                            .frame(width: 48, height: 48)
                            .overlay(
                                Button(action: {
                                    //
                                }, label: {
                                    VStack(spacing: 0) {
                                        Image("add_circle")
                                            .resizable()
                                            .frame(width: 32, height: 32)
                                            .foregroundColor(.white)
                                        Text("Nuevo")
                                            .font(Font.custom("InterTight", size: Sizes.caption))
                                            .foregroundColor(.white)
                                    }
                                })
                            )
                            .shadow(color: .accentColor.opacity(0.25), radius: 4, x: 0, y: 4)
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.clear)
                            .stroke(.white, lineWidth: 1)
                            .frame(width: 48, height: 48)
                            .overlay(
                                Button(action: {
                                    userAuth.signOut()
                                }, label: {
                                    VStack(spacing: 0) {
                                        Image("manage_accounts")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(.white)
                                        Text("Perfil")
                                            .font(Font.custom("InterTight", size: Sizes.caption))
                                    }
                                })
                            )
                    }
                }
                .padding(.bottom, 8)
                .font(Font.custom("Roboto-Regular", size: Sizes.body))
                .frame(height: 80)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(.secondaryDark)
                .foregroundColor(.white)
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct BudgetListingView_Previews: PreviewProvider {
    @StateObject var userAuth = UserViewModel()
    
    static var previews: some View {
        NavigationStack {
            VStack {
                BudgetListingView()
            }
            .environmentObject({ () -> UserViewModel in
                let envObj = UserViewModel()
                return envObj
            }())
        }
        .colorScheme(.light)
    }
}
