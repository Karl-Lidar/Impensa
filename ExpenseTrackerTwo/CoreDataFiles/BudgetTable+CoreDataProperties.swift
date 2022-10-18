//
//  BudgetTable+CoreDataProperties.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-30.
//
//

import Foundation
import CoreData


extension BudgetTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BudgetTable> {
        return NSFetchRequest<BudgetTable>(entityName: "BudgetTable")
    }

    @NSManaged public var createdDate: Date?
    @NSManaged public var currency: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var budgetGoals: NSSet?
    @NSManaged public var expenses: NSSet?
    
    public var wrappedExpenses: [Expense] {
        let set = expenses as? Set<Expense> ?? []
        return set.sorted {
            $0.name! < $1.name!
        }
    }
    
    public var wrappedBudgetGoal: [BudgetGoals] {
        let set = budgetGoals as? Set<BudgetGoals> ?? []
        return set.sorted {
            $0.goalAmount < $1.goalAmount
        }
    }

}

// MARK: Generated accessors for budgetGoals
extension BudgetTable {

    @objc(addBudgetGoalsObject:)
    @NSManaged public func addToBudgetGoals(_ value: BudgetGoals)

    @objc(removeBudgetGoalsObject:)
    @NSManaged public func removeFromBudgetGoals(_ value: BudgetGoals)

    @objc(addBudgetGoals:)
    @NSManaged public func addToBudgetGoals(_ values: NSSet)

    @objc(removeBudgetGoals:)
    @NSManaged public func removeFromBudgetGoals(_ values: NSSet)

}

// MARK: Generated accessors for expenses
extension BudgetTable {

    @objc(addExpensesObject:)
    @NSManaged public func addToExpenses(_ value: Expense)

    @objc(removeExpensesObject:)
    @NSManaged public func removeFromExpenses(_ value: Expense)

    @objc(addExpenses:)
    @NSManaged public func addToExpenses(_ values: NSSet)

    @objc(removeExpenses:)
    @NSManaged public func removeFromExpenses(_ values: NSSet)

}

extension BudgetTable : Identifiable {

}
