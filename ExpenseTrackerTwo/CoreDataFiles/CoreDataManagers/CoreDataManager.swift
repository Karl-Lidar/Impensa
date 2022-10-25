//
//  CoreDataManager.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-13.
//

import Foundation
import SwiftUI
import CoreData

class CoreDataManager {
    
    var viewContext: NSManagedObjectContext
    var expenseCategoryCoreDataManager: CoreDataExpenseCategoryManager
    var coreDataBudgetManager: CoreDataBudgetManager
    var coreDataExpenseManager: CoreDataExpenseManager
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        self.expenseCategoryCoreDataManager = CoreDataExpenseCategoryManager(context: viewContext)
        self.coreDataBudgetManager = CoreDataBudgetManager(context: viewContext)
        self.coreDataExpenseManager = CoreDataExpenseManager(context: viewContext)
        
    }
    
    func generateExpenseCategories() {
        let coreDataExpenseCategoryManager = CoreDataExpenseCategoryManager(context: viewContext)
        coreDataExpenseCategoryManager.generateExpenseCategories()
    }
    
    
}
