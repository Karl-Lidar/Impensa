//
//  BudgetGoals+CoreDataProperties.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-13.
//
//

import Foundation
import CoreData


extension BudgetGoals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BudgetGoals> {
        return NSFetchRequest<BudgetGoals>(entityName: "BudgetGoals")
    }

    @NSManaged public var goalAmount: Double
    @NSManaged public var id: UUID?
    @NSManaged public var budgetTable: BudgetTable?
    @NSManaged public var expenseCategory: ExpenseCategory?

}

extension BudgetGoals : Identifiable {

}
