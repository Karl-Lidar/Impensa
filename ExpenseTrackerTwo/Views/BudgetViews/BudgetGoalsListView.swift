//
//  BudgetGoalsListView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-01.
//

import SwiftUI

struct BudgetGoalsListView: View {
    
    @Binding var budgetGoals: [TempBudgetGoals]
    
    var body: some View {
        List {
            ForEach(budgetGoals, id: \.self) { goal in
                VStack {
                    Spacer()
                    HStack {
                        Text(goal.category.name!)
                            .frame(alignment: .leading)
                        Text("\(String(goal.amount))")
                            .frame(alignment: .trailing)
                    }
                    Spacer()
                }
                }
            
            NavigationLink(destination: AddBudgetGoal(budgetGoals: $budgetGoals)) {
               ListViewLinkButton(buttonName: "New goal", buttonHeight: 40)
            }
        }
        .padding()
    }
}
