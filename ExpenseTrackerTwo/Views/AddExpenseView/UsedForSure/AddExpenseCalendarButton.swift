//
//  AddExpenseCalendarButton.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-19.
//

import SwiftUI

struct AddExpenseCalendarButton: View {
    
    @Binding var openPickDateView: Bool
    @Binding var blurView: Bool
    @Binding var currentCategoryColor: Color
    
    var body: some View {
        Button {
            withAnimation {
                openPickDateView.toggle()
                blurView.toggle()
            }
        } label: {
            ZStack {
            Color.white
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
                Image(systemName: "calendar")
                    .foregroundColor(currentCategoryColor)
            }
        }
    }
}

struct AddExpenseCalendarButton_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseCalendarButton(openPickDateView: .constant(false), blurView: .constant(false), currentCategoryColor: .constant(Color.green))
    }
}
