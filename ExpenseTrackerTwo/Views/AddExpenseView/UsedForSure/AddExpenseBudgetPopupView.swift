//
//  AddExpenseBudgetPopupView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-19.
//

import SwiftUI

struct AddExpenseBudgetPopupView: View {
    
    @Binding var selectedBudgetName: String
    @Binding var showBudgets: Bool
    @Binding var blurView: Bool
    @Binding var currentCategoryColor: Color
    
    var body: some View {
        
        ZStack {
            Color(UIColor.systemGray6)
                .frame(width: 250, height: 430, alignment: .center)
            
            VStack {
                BudgetTableListView(selectedCategoryName: $selectedBudgetName)
                    .frame(width: 250, height: 350, alignment: .center)
                Spacer()
            }
            
            VStack {
                Spacer()
                Color.white
                    .frame(width: 250, height: 80, alignment: .center)
            }
            
            VStack {
                Spacer()
                Button {
                    withAnimation {
                        showBudgets.toggle()
                        blurView.toggle()
                    }
                } label: {
                    ZStack {
                        currentCategoryColor
                            .frame(width: 150, height: 40, alignment: .center)
                            .cornerRadius(20)
                        Text("OK")
                            .foregroundColor(Color.white)
                    }
                }
                .customShadow()
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            }
        }
        .fixedSize()
        .cornerRadius(25)
    }
}

struct AddExpenseBudgetPopupView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseBudgetPopupView(selectedBudgetName: .constant("Budget"), showBudgets: .constant(false), blurView: .constant(false), currentCategoryColor: .constant(Color.green))
    }
}
