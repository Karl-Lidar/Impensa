//
//  BudgetTableListObject.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-02.
//

import SwiftUI

struct BudgetTableListObject: View {
    
    @Binding var selectedBudgetName: String
    var budgetTable: BudgetTable
    
    var body: some View {
        ZStack {
            if budgetTable.name! == selectedBudgetName {
                Color(UIColor.systemGray5)
                    .frame(width: 200, height: 40, alignment: .center)
                    .cornerRadius(20)
            }
        Button {
            if selectedBudgetName != budgetTable.name! {
            selectedBudgetName = budgetTable.name!
            } else {
                selectedBudgetName = ""
            }
        } label: {
            Text("\(budgetTable.name!)")
        }
        }
    }
}


