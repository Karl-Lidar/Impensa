//
//  ExpenseCategory+CoreDataProperties.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-17.
//
//

import Foundation
import CoreData


extension ExpenseCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseCategory> {
        return NSFetchRequest<ExpenseCategory>(entityName: "ExpenseCategory")
    }

    @NSManaged public var colorHEX: String?
    @NSManaged public var colorName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var imageName: String?
    @NSManaged public var name: String?
    @NSManaged public var budgetGoal: NSSet?
    @NSManaged public var expense: NSSet?
    
    public var wrappedExpenses: [Expense] {
        let set = expense as? Set<Expense> ?? []
        return set.sorted {
            $0.name! < $1.name!
        }
    }
}

// MARK: Generated accessors for budgetGoal
extension ExpenseCategory {

    @objc(addBudgetGoalObject:)
    @NSManaged public func addToBudgetGoal(_ value: BudgetGoals)

    @objc(removeBudgetGoalObject:)
    @NSManaged public func removeFromBudgetGoal(_ value: BudgetGoals)

    @objc(addBudgetGoal:)
    @NSManaged public func addToBudgetGoal(_ values: NSSet)

    @objc(removeBudgetGoal:)
    @NSManaged public func removeFromBudgetGoal(_ values: NSSet)

}

// MARK: Generated accessors for expense
extension ExpenseCategory {

    @objc(addExpenseObject:)
    @NSManaged public func addToExpense(_ value: Expense)

    @objc(removeExpenseObject:)
    @NSManaged public func removeFromExpense(_ value: Expense)

    @objc(addExpense:)
    @NSManaged public func addToExpense(_ values: NSSet)

    @objc(removeExpense:)
    @NSManaged public func removeFromExpense(_ values: NSSet)

}

extension ExpenseCategory : Identifiable {

}
