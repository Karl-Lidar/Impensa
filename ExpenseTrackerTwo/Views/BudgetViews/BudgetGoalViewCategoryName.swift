//
//  BudgetGoalViewCategoryName.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-24.
//

import SwiftUI

struct BudgetGoalViewCategoryName: View {
    
    @ObservedObject var category: ExpenseCategory
    
    var body: some View {
        Text(String(getText()))
    }
    
    func getText() -> String {
        if let name = category.name {
            return name
        } else {
            return "Fungerar ej"
        }
    }
}
