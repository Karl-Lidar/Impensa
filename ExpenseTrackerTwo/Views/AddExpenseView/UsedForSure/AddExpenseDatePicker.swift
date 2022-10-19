//
//  AddExpenseDatePicker.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-19.
//

import SwiftUI

struct AddExpenseDatePicker: View {
    
    @Binding var date: Date
    @Binding var openDatePicker: Bool
    @Binding var blurView: Bool
    @Binding var currentCategoryColor: Color
    
    var body: some View {
        
        ZStack {
            Color(UIColor.systemGray6)
            
            VStack {
                Spacer()
                ZStack {
                    Color.white
                        .frame(width: 300, height: 80, alignment: .center)
                    Button {
                        withAnimation {
                            openDatePicker.toggle()
                            blurView.toggle()
                        }
                    } label: {
                        ZStack {
                            currentCategoryColor
                                .frame(width: 150, height: 40, alignment: .center)
                                .cornerRadius(40)
                            Text("Ok")
                                .foregroundColor(Color.white)
                        }
                    }
                    .customShadow()
                }
            }
            
            VStack {
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .accentColor(currentCategoryColor)
                Spacer()
            }
            .customShadow()
            .frame(width: 300, height: 400, alignment: .center)
            .datePickerStyle(.graphical)
            
           
        }
        .frame(width: 300, height: 430, alignment: .center)
        .fixedSize()
        .cornerRadius(25)
    }
}

struct AddExpenseDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseDatePicker(date: .constant(Date()), openDatePicker: .constant(false), blurView: .constant(false), currentCategoryColor: .constant(Color.green))
    }
}
