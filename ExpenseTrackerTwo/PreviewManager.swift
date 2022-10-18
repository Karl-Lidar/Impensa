//
//  PreviewManager.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-07.
//

import Foundation
import SwiftUI
import CoreData



class PreviewManager {
    
    var context: NSManagedObjectContext
    
    private var budgetGoalAmounts = [7500.0, 4000.0, 500.0, 1000.0, 2000.0]
    var categoryNames: [String] = ["Bränsle", "Mat", "Aktiviteter","Vägtullar","Annat"]
    var imageName: [String] = ["person.circle.fill", "person.3.sequence.fill","person.crop.circle.fill.badge.checkmark", "person.crop.circle.badge", "eye.fill"]
    var expensesAmount: [Double] = [1324, 422, 85, 760, 121, 56, 605, 340, 899, 67, 566]
    var expensesName: [String] = ["Tankning Annecy", "Dejt Annecy", "Vandring ravin", "Handla mat", "Tygkasse köpt", "Glass dejt", "Kanot paddling", "Vägtull till Grenoble", "Tankning Grenoble", "Frukost macka", "Handla mat"]
    var expenseCategories: [String] = ["Bränsle", "Mat", "Aktiviteter", "Mat", "Annat", "Mat", "Aktiviteter", "Vägtullar", "Bränsle", "Mat", "Mat"]
    var colorName: [String] = ["Red", "Green", "Blue", "Brown", "Yellow"]
    
    init(viewContext: NSManagedObjectContext) {
        self.context = viewContext
    }
    
    func getCompleteBudgetTable() -> BudgetTable {
        let budgetTable = createBasicBudgetTable()
       addAllBudgetGoals(budgetTable: budgetTable)
        return budgetTable
    }
    
    func getSingleExpense() -> Expense {
        var budgetTable = getCompleteBudgetTable()
        var expense = budgetTable.wrappedBudgetGoal[0].expenseCategory!.wrappedExpenses[0]
        return expense
    }
    
    private func addAllBudgetGoals(budgetTable: BudgetTable) -> [BudgetGoals] {
        var budgetGoals: [BudgetGoals] = []
        for element in 0..<budgetGoalAmounts.count {
            let budgetGoal = BudgetGoals(context: context)
            budgetGoal.id = UUID()
            budgetGoal.goalAmount = budgetGoalAmounts[element]
            budgetGoal.budgetTable = budgetTable
            budgetGoal.expenseCategory = addAndConnectExpenseCategoryToBudgetGoal(budgetGoal: budgetGoal, element: element)
            budgetGoals.append(budgetGoal)
            saveContext()
        }
        return budgetGoals
    }
    
    //Creates categories and connects them to a specific goal
    private func addAndConnectExpenseCategoryToBudgetGoal(budgetGoal: BudgetGoals,element: Int) -> ExpenseCategory {
        let expenseCategory = ExpenseCategory(context: context)
        expenseCategory.imageName = imageName[element]
        expenseCategory.name = categoryNames[element]
        expenseCategory.id = UUID()
        expenseCategory.colorName = colorName[element]
        expenseCategory.addToBudgetGoal(budgetGoal)
        addExpensesForCategory(expenseCategory: expenseCategory)
        saveContext()
        return expenseCategory
    }
    
    private func addExpensesForCategory(expenseCategory: ExpenseCategory) {
        for element in 0..<expensesAmount.count {
            if expenseCategories[element] == expenseCategory.name! {
                let expense = Expense(context: context)
                expense.expenseCategory = expenseCategory
                expense.amount = expensesAmount[element]
                expense.id = UUID()
                expense.name = expensesName[element]
                expense.date = Date()
                saveContext()
            }
        }
    }
    
    private func createBasicBudgetTable() -> BudgetTable {
        let budgetTable = BudgetTable(context: context)
        budgetTable.currency = "SEK"
        budgetTable.name = "BasicBudget"
        budgetTable.createdDate = Date()
        budgetTable.id = UUID()
        return budgetTable
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
