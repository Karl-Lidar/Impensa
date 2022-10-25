//
//  BudgetGoalsListView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-01.
//

import SwiftUI

struct BudgetGoalsListView: View {
    
    @Binding var budgetGoals: [TempBudgetGoals]
    @Binding var backgroundSplashColor: Color
    
    var body: some View {
      
        List {
            NavigationLink(destination: AddBudgetGoal(budgetGoals: $budgetGoals, mode: .Save, backgroundSplashColor: $backgroundSplashColor)) {
               ListViewLinkButton(buttonName: "New goal", buttonHeight: 40)
            }
            
            ForEach(budgetGoals, id: \.self) { goal in
               
                NavigationLink {
                    //AddBudgetGoal(budgetGoals: $budgetGoals, mode: .Update)
                    AddBudgetGoal(budgetGoals: $budgetGoals, mode: .Update, amount: goal.amount, expenseCategory: goal.category, backgroundSplashColor: $backgroundSplashColor, idForBugdetGoal: goal.id)
                        .onAppear {
                            backgroundSplashColor = StringColorConverter().colorFor(colorName: goal.category.colorName!)
                        }
                        
                } label: {
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
                }
        }
        .cornerRadius(25)
        .padding()
    
    }
}
