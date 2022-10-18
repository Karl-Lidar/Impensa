//
//  CoreDataBudgetManager.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-01.
//

import Foundation
import SwiftUI
import CoreData

class CoreDataBudgetManager {
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func createbudgetTable(budgetName: String, budgetGoals: [TempBudgetGoals]) {
        let budgetTable = BudgetTable(context: context)
        budgetTable.name = budgetName
        budgetTable.id = UUID()
        budgetTable.createdDate = Date()
        budgetTable.currency = "SEK"
        
        for goal in budgetGoals {
            let budgetGoal = BudgetGoals(context: context)
            budgetGoal.id = UUID()
            budgetGoal.goalAmount = goal.amount
            budgetGoal.expenseCategory = goal.category
            budgetTable.addToBudgetGoals(budgetGoal)
            saveContext()
        }
        
        saveContext()
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
