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
        
        GeometryReader { geometry in
            ZStack {
                if budgetTable.name! == selectedBudgetName {
                    Color(UIColor.systemGray5)
                        .frame(width: 150, height: 25, alignment: .center)
                        .cornerRadius(20)
                }
                
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                Text("\(budgetTable.name!)")
                    .foregroundColor(Color.black.opacity(0.9))
                        Spacer()
                    }
                    Spacer()
                }
             /*
            Button {
                if selectedBudgetName != budgetTable.name! {
                selectedBudgetName = budgetTable.name!
                } else {
                    selectedBudgetName = ""
                }
            } label: {
                HStack {
                    Spacer()
                Text("\(budgetTable.name!)")
                    .foregroundColor(Color.black.opacity(0.9))
                    Spacer()
                }
            }
                */
            }
        }
        .onTapGesture {
            if selectedBudgetName != budgetTable.name! {
            selectedBudgetName = budgetTable.name!
            } else {
                selectedBudgetName = "Budget"
            }
        }
       
    }
}


