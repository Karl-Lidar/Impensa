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
    
    func deleteBudgetTable(budgetTable: BudgetTable)  {
        context.delete(budgetTable)
        saveContext()
    }
    
    func updateBudgetTable(budgetName: String, budgetGoals: [TempBudgetGoals], currentBudget: BudgetTable) {
        
        var didFindID = false
        
        if currentBudget.name! != budgetName {
            currentBudget.name = budgetName
        }
        
        
        //SEARCH FOR ANY GOALS EXISTING IN CORE DATA BUT NOT IN TEMP
        for budgetGoal in currentBudget.wrappedBudgetGoal {
            
            var didFindCoreDataGoalInTemp = false
            
            for goal in budgetGoals {
                if budgetGoal.id! == goal.id {
                    didFindCoreDataGoalInTemp = true
                }
            }
            
            if didFindCoreDataGoalInTemp == false {
                context.delete(budgetGoal)
                saveContext()
            }
            
            didFindCoreDataGoalInTemp = false
        }
        
        for goal in budgetGoals {
            for budgetGoal in currentBudget.wrappedBudgetGoal {
                if goal.id == budgetGoal.id! {
                    didFindID = true
                    budgetGoal.goalAmount = goal.amount
                    budgetGoal.expenseCategory = goal.category
                    break
                }
            }
            
            if didFindID == false {
                let budgetGoal = BudgetGoals(context: context)
                budgetGoal.expenseCategory = goal.category
                budgetGoal.goalAmount = goal.amount
                budgetGoal.id = UUID()
                currentBudget.addToBudgetGoals(budgetGoal)
                saveContext()
            }
            
            didFindID = false
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
