//
//  StringColorConverter.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-21.
//

import Foundation
import SwiftUI

class StringColorConverter {
    //["Red", "Green", "Blue", "Brown", "Yellow"]
    var stringColors = ["Red": Color.red, "Green": Color.green, "Blue": Color.blue, "Brown": Color.brown, "Yellow": Color.yellow, "Pink": Color.pink, "Purple": Color.purple, "Gray": Color.gray, "Cyan": Color.cyan, "Indigo": Color.indigo, "Orange": Color.orange, "Mint": Color.mint]
    
    init() {
        
    }

    
    func colorFor(colorName: String) -> Color {
        return stringColors[colorName]!
    }
    
    func colorForExpense(expense: ExpenseCategory) -> Color {
        return stringColors[expense.colorName!]!
    }
    //Testa att passa pbservedobject och
    
    func stringFor(color: Color) -> String {
        switch color {
        case Color.red:
            return "Red"
        case Color.green:
            return "Green"
        case Color.blue:
            return "Blue"
        case Color.brown:
            return "Brown"
        case Color.yellow:
            return "Yellow"
        case Color.pink:
            return "Pink"
        case Color.purple:
            return "Purple"
        case Color.gray:
            return "Gray"
        case Color.cyan:
            return "Cyan"
        case Color.indigo:
            return "Indigo"
        case Color.orange:
            return "Orange"
        case Color.mint:
            return "Mint"
        default:
            return "Red"
        }
        
    }
}

class StringColorConverterWithExpenseCategory {
    //["Red", "Green", "Blue", "Brown", "Yellow"]
    var stringColors = ["Red": Color.red, "Green": Color.green, "Blue": Color.blue, "Brown": Color.brown, "Yellow": Color.yellow, "Pink": Color.pink, "Purple": Color.purple, "Gray": Color.gray, "Cyan": Color.cyan, "Indigo": Color.indigo, "Orange": Color.orange, "Mint": Color.mint]
    
    @ObservedObject var expenseCategory: ExpenseCategory
    
    init(expenseCategory: ExpenseCategory) {
        self.expenseCategory = expenseCategory
    }

    
    func colorFor(colorName: String) -> Color {
        return stringColors[colorName]!
    }
    
    func colorForExpenseCategory() -> Color {
        return stringColors[expenseCategory.colorName!]!
    }
    //Testa att passa pbservedobject och
    
    func stringFor(color: Color) -> String {
        switch color {
        case Color.red:
            return "Red"
        case Color.green:
            return "Green"
        case Color.blue:
            return "Blue"
        case Color.brown:
            return "Brown"
        case Color.yellow:
            return "Yellow"
        case Color.pink:
            return "Pink"
        case Color.purple:
            return "Purple"
        case Color.gray:
            return "Gray"
        case Color.cyan:
            return "Cyan"
        case Color.indigo:
            return "Indigo"
        case Color.orange:
            return "Orange"
        case Color.mint:
            return "Mint"
        default:
            return "Red"
        }
        
    }
}
