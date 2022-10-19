//
//  AddExpenseTextInputView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-19.
//

import SwiftUI

struct AddExpenseTextInputView: View {
    
    @Binding var textInput: String
    var holderText: String
    
    var body: some View {
        TextField(holderText, text: $textInput)
            .multilineTextAlignment(.center)
            .foregroundColor(Color.black.opacity(0.9))
            .font(Font.system(size: 30))
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
           
        Divider()
            .frame(height: 1, alignment: .center)
            .padding(.horizontal, 30)
            .background(Color.black.opacity(0.2))
    }
}

struct AddExpenseTextInputView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseTextInputView(textInput: .constant(""), holderText: "Expense")
    }
}
