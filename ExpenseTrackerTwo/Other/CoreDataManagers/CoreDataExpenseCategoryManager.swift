//
//  CoreDataExpenseCategoryManager.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-13.
//

import Foundation
import SwiftUI
import CoreData

class CoreDataExpenseCategoryManager {
    
    var viewContext: NSManagedObjectContext
    var categoryNames: [String] = ["Bränsle", "Mat", "Aktiviteter","Vägtullar","Annat"]
    var imageName: [String] = ["person.circle.fill", "person.3.sequence.fill","person.crop.circle.fill.badge.checkmark", "person.crop.circle.badge", "eye.fill"]
    var colorName: [String] = ["Red", "Green", "Blue", "Brown", "Yellow"]
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
    }
    
    func generateExpenseCategories() {
        
        for element in 0..<categoryNames.count {
            var expenseCategory = ExpenseCategory(context: viewContext)
            expenseCategory.id = UUID()
            expenseCategory.name = categoryNames[element]
            expenseCategory.imageName = imageName[element]
            expenseCategory.colorName = colorName[element]
            saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func createNewExpenseCategory(name: String, color: String) {
        let expenseCategory = ExpenseCategory(context: viewContext)
        expenseCategory.colorName = color
        expenseCategory.name = name
        expenseCategory.id = UUID()
        saveContext()
    }
    
    func updateExpenseCategory(expenseCategory: ExpenseCategory, name: String, color: String) {
        
        if expenseCategory.name! != name {
            expenseCategory.name! = name
        }
        
        if expenseCategory.colorName! != color {
            expenseCategory.colorName = color
        }
        
        saveContext()
    }
}
