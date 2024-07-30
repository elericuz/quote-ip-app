//
//  BudgetItemView.swift
//  MyBudget
//
//  Created by Eric Valera Miller on 24/07/24.
//

import SwiftUI

struct BudgetItemView: View {
    @State private var awarded: Bool = false
    @State var budget: BudgetItem

    init(budget: BudgetItem) {
        _budget = State(initialValue: budget)
        _awarded = State(initialValue: budget.awarded != 0)
    }
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(.clear)
                .frame(height: 88)
                .overlay(
                    VStack(alignment: .leading, spacing: 4) {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(budget.budgetName)
                                        .font(Font.custom("Poppins-SemiBold", size: Sizes.body))
                                        .foregroundColor(.primaryDark)
                                        .shadow(color: .secondaryDark.opacity(0.25), radius: 5, x: 0, y: 4)
                                    Text(budget.clientName)
                                        .font(Font.custom("InterTight", size: Sizes.caption))
                                        .foregroundColor(.accentColor)
                                        .fontWeight(.bold)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                Spacer()
                                Button(action: {
                                    awarded.toggle()
                                }, label: {
                                    VStack {
                                        Image("award_star")
                                            .resizable()
                                            .foregroundColor(awarded ? .tertiaryDark : .backgroundLight)
                                            .frame(width: 32, height: 32)
                                    }
                                    .frame(width: 40)
                                    .frame(maxHeight: .infinity)
                                })
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Fecha:")
                                        .frame(width: 45, alignment: .trailing)
                                    Text(budget.budgetDate)
                                }
                                HStack {
                                    Text("Horas:")
                                        .frame(width: 45, alignment: .trailing)
                                    Text("\(budget.workingHours)")
                                }
                            }
                            .frame(width: 150, alignment: .leading)
                            Spacer()
                            VStack(alignment: .trailing) {
                                HStack {
                                    Text("T. Soles:")
                                        .frame(width: 70, alignment: .trailing)
                                    Text("\(budget.totalSoles, specifier: "%.2f")")
                                        .frame(width: 80, alignment: .trailing)
                                }
                                HStack {
                                    Text("T. Dólares:")
                                        .frame(width: 70, alignment: .trailing)
                                    Text("\(budget.totalDollars, specifier: "%.2f")")
                                        .frame(width: 80, alignment: .trailing)
                                }
                            }
                            .frame(width: 150, alignment: .trailing)
                        }
                        .font(Font.custom("Poppins-Light", size: Sizes.placeholder))
                    }
                    .foregroundColor(.accentDark)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                )
        }
        .padding(.horizontal, 16)
    }
}


struct BudgetItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack {
                BudgetItemView(budget: BudgetItem(budgetName: "Sistema de encuestas", clientName: "Reimagina", budgetDate: "24/07/2024", workingHours: 328, totalSoles: 10961.95, totalDollars: 2962.69, awarded: 01))
            }
            .ignoresSafeArea(.all)
        }
        .colorScheme(.light)
    }
}
