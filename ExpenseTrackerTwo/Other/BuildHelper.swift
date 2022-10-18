//
//  BuildHelper.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-11.
//

import Foundation
import SwiftUI
import CoreData

class BuildHelper {
    
    var viewContext: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.viewContext = context
    }
    
    func addBudgetTable()  {
        
        let budgetTable = BudgetTable(context: viewContext)
        budgetTable.name = "BudgetNames"
        budgetTable.currency = "SEK"
        budgetTable.createdDate = Date()
        budgetTable.id = UUID()
        
        var goalAmount: [Double] = [1000.0, 2000.0, 3000.0, 4000.0, 5000.0]
        
        for element in 0..<5 {
            let budgetGoals = BudgetGoals(context: viewContext)
            budgetGoals.goalAmount = goalAmount[element]
            budgetGoals.budgetTable = budgetTable
            budgetGoals.id = UUID()
          
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
