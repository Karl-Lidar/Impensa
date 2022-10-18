//
//  Expense+CoreDataProperties.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-30.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var expenseCategory: ExpenseCategory?
    @NSManaged public var budget: BudgetTable?

}

extension Expense : Identifiable {

}
