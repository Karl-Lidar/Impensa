//
//  AddExpenseTextInputView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-02.
//

import SwiftUI

struct AddExpenseTextInputView: View {
    
    var expensePageNumber = 1
    @Binding var currentAddExpensePage: Int
    @Binding var expenseName: String
    @Binding var amountString: String
    @State var withSaveButton: Bool
    
    var body: some View {
       
        GeometryReader { geometry in
            VStack {
                TextField("Expense Name", text: $expenseName)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.black.opacity(0.9))
                    .font(Font.system(size: 30))
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                    
                    Divider()
                        .frame(width: geometry.size.width/2, height: 1)
                     .padding(.horizontal, 30)
                     .background(Color.black.opacity(0.2))
                    
                     
                TextField("Amount (kr)", text: $amountString)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.black.opacity(0.9))
                            .font(Font.system(size: 30))
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                            
                            Divider()
                        .frame(width: geometry.size.width/2, height: 1)
                             .padding(.horizontal, 30)
                             .background(Color.black.opacity(0.2))
                
                if withSaveButton == true {
                    Button {
                        withAnimation {
                            currentAddExpensePage = expensePageNumber+1
                        }
                    } label: {
                        SaveButtonView(color: Color.green)
                    }
                    .padding()
                }
            }
        }
    }
}

