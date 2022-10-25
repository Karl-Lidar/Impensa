//
//  AddExpenseDeleteButton.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-24.
//

import SwiftUI

struct AddExpenseDeleteButton: View {
    
    @Binding var currentCategoryColor: Color
    @Binding var openDeleteAlert: Bool
    
    var body: some View {
        Button {
            withAnimation {
                openDeleteAlert.toggle()
            }
        } label: {
            ZStack {
            Color.white
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
                Image(systemName: "trash.fill")
                    .foregroundColor(currentCategoryColor)
            }
        }
    }
}

struct AddExpenseDeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseDeleteButton(currentCategoryColor: .constant(Color.green), openDeleteAlert: .constant(false))
    }
}
