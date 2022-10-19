//
//  CoreDataExpenseManager.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-25.
//

import Foundation
import SwiftUI
import CoreData

class CoreDataExpenseManager {

    var viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
    }
    
    func createNewExpense(expenseName: String, expenseAmount: Double, expenseCategory: ExpenseCategory, budgetTable: BudgetTable, date: Date) {
        
        let expense = Expense(context: viewContext)
        expense.expenseCategory = expenseCategory
        expense.id = UUID()
        expense.name = expenseName
        expense.amount = expenseAmount
        expense.date = date
        expense.budget = budgetTable
        
        saveContext()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
