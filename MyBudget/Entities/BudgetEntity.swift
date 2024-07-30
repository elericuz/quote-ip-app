//
//  BudgetEntity.swift
//  MyBudget
//
//  Created by Eric Valera Miller on 29/07/24.
//

import Foundation

struct BudgetItem: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var budgetName: String
    var clientName: String
    var budgetDate: String
    var workingHours: Int
    var totalSoles: Double
    var totalDollars: Double
    var awarded: Int
}

var budgetList: [BudgetItem] = [
    BudgetItem(budgetName: "Sistema de encuestas", clientName: "Reimagina", budgetDate: "24/07/2024", workingHours: 328, totalSoles: 10961.95, totalDollars: 2962.69, awarded: 0),
    BudgetItem(budgetName: "Análisis de fotos", clientName: "Reimagina", budgetDate: "24/07/2024", workingHours: 32, totalSoles: 2590.00, totalDollars: 700.00, awarded: 0),
    BudgetItem(budgetName: "Sorteos", clientName: "Reimagina", budgetDate: "24/07/2024", workingHours: 84, totalSoles: 2279.20, totalDollars: 616.00, awarded: 1),
    BudgetItem(budgetName: "Encuestas para Gloria", clientName: "Reimagina", budgetDate: "24/07/2024", workingHours: 550, totalSoles: 20350.00, totalDollars: 5500.00, awarded: 0),
    BudgetItem(budgetName: "Internet Base Naval Ancón", clientName: "Reimagina", budgetDate: "24/07/2024", workingHours: 80, totalSoles: 3700.00, totalDollars: 1000.00, awarded: 0),
    BudgetItem(budgetName: "Tarjetas de estudiantes del Metro de Lima", clientName: "Reimagina", budgetDate: "24/07/2024", workingHours: 234, totalSoles: 27900.00, totalDollars: 7540.54, awarded: 0),
    BudgetItem(budgetName: "Saldo de tarjetas del Metro de Lima", clientName: "Reimagina", budgetDate: "24/07/2024", workingHours: 181, totalSoles: 4600.00, totalDollars: 1243.24, awarded: 1)
]
