//
//  ExpenseSettingView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-02.
//

import SwiftUI

struct ExpenseSettingView: View {
    
    @State var currentPage = 1
    @State var amountString: String
    @State var expenseName: String
    @State var selectedCatoryName: String
    @State var selectedBudgetName: String
    var expense: Expense
    
    @State var blurView = false

    var body: some View {
       
        GeometryReader { geometry in
            ZStack {
                BackgroundSplashView(multiplier: 1.3, color: StringColorConverter().colorFor(colorName: expense.expenseCategory!.colorName!))
            VStack {
                Spacer()
                /*
                AddExpenseTextInputView(currentAddExpensePage: $currentPage, expenseName: $expenseName, amountString: $amountString, withSaveButton: false, showCategories: .constant(false), blurView: $blurView)
                    .frame(width: geometry.size.width, height: 150)
                 */
                    
                    
                NavigationLink(destination: ExpenseSettingCategoryView(selectedCatoryName: $selectedCatoryName)
                    .navigationTitle(Text("Change category"))) {
                    ZStack {
                        Color.white
                            .cornerRadius(50/2)
                        
                        HStack {
                         
                            Spacer()
                            Text(expense.expenseCategory!.name!)
                                .foregroundColor(StringColorConverter().colorFor(colorName: expense.expenseCategory!.colorName!).opacity(0.8))
                            Spacer()
                                Image(systemName: "chevron.forward")
                                .foregroundColor(StringColorConverter().colorFor(colorName: expense.expenseCategory!.colorName!).opacity(0.8))
                            
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    }
                    .frame(width: geometry.size.width/1.7, height: 50)
                }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                
                NavigationLink(destination: ExpenseSettingBudgetView(selectedBudgetName: $selectedBudgetName)) {
                    ZStack {
                        Color.white
                            .cornerRadius(50/2)
                            
                        HStack {
                            Spacer()
                            Text(expense.budget!.name!)
                                .foregroundColor(StringColorConverter().colorFor(colorName: expense.expenseCategory!.colorName!).opacity(0.8))
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(StringColorConverter().colorFor(colorName: expense.expenseCategory!.colorName!).opacity(0.8))
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    }
                    .frame(width: geometry.size.width/1.7, height: 50)
                }
 
                Spacer()
            
            }
            .navigationTitle(Text("Edit expense"))
        }
        }
    }
}
