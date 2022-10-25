//
//  BudgetGoalView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-07.
//

import SwiftUI
import CoreData

struct BudgetGoalView: View {
    
    @FetchRequest var fetchRequest: FetchedResults<Expense>
    @ObservedObject var budgetGoal: BudgetGoals
    @ObservedObject var expenseCategory: ExpenseCategory
    
    var stringColors = ["Red": Color.red, "Green": Color.green, "Blue": Color.blue, "Brown": Color.brown, "Yellow": Color.yellow, "Pink": Color.pink, "Purple": Color.purple, "Gray": Color.gray, "Cyan": Color.cyan, "Indigo": Color.indigo, "Orange": Color.orange, "Mint": Color.mint]
  
    var body: some View {
        
        GeometryReader { geometry in

            VStack {
                HStack {
                    //Does not update because expenseCategory is not observed
                    BudgetGoalViewCategoryName(category: expenseCategory)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    Text("\(calculateTotalAmountOfExpensesWithinCategory(), specifier: "%.0f")/\(budgetGoal.goalAmount, specifier: "%.0f") sek")
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    Spacer()
                }
               
                ZStack {
                    HStack {
                    Color(uiColor: UIColor.systemGray5)
                        .frame(width: geometry.size.width, height: 20)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        Spacer()
                    }
                        
                    HStack {
                       // StringColorConverterWithExpenseCategory(expenseCategory: expenseCategory).colorForExpenseCategory()
                        getColorForCategory(category: expenseCategory)
                            .opacity(0.8)
                            .frame(width: widthForExpense(totalExpenseAmount: calculateTotalAmountOfExpensesWithinCategory(), goalAmount: budgetGoal.goalAmount, displayBarWidth: geometry.size.width, barHeight: 20, maxWidth: geometry.size.width), height: 20)
                        .cornerRadius(20)
                        Spacer()
                    }
                }
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        }
    }
    
    func getColorForCategory(category: ExpenseCategory) -> Color {
        
        if let color = category.colorName {
            return stringColors[color]!
        } else {
            return Color.green
        }
    }

    init(filterValue: ExpenseCategory, budgetGoal: BudgetGoals, budgetTable: BudgetTable) {
        _fetchRequest = FetchRequest<Expense>(sortDescriptors: [], predicate: NSPredicate(format: "expenseCategory == %@ AND budget == %@", filterValue, budgetTable))
        self.budgetGoal = budgetGoal
        self.expenseCategory = filterValue
    }
    
    private func widthForExpense(totalExpenseAmount: Double, goalAmount: Double, displayBarWidth: CGFloat, barHeight: CGFloat, maxWidth: CGFloat) -> CGFloat {
        
        var widthToUse = (totalExpenseAmount/goalAmount)*displayBarWidth
        
        if widthToUse >= barHeight && widthToUse <= maxWidth {
            return widthToUse
        } else {
            
            if widthToUse >= barHeight {
                return maxWidth
            } else {
                return barHeight
            }
        }
    }
    
    private func calculateTotalAmountOfExpensesWithinCategory() -> Double {
        var totalAmount: Double = 0
        for fetch in fetchRequest {
            totalAmount += fetch.amount
        }
        return totalAmount
    }
}

