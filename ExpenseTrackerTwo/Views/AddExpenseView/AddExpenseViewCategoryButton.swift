//
//  AddExpenseViewCategoryButton.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-25.
//

import SwiftUI

struct AddExpenseViewCategoryButton: View {
    
    @Binding var selectedCatoryName: String
    var category: ExpenseCategory
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
            HStack {
                
                ZStack {
                    
                    if selectedCatoryName == category.name! {
                    StringColorConverter().colorFor(colorName: category.colorName!)
                        .opacity(0.2)
                        .frame(height: 25)
                        .cornerRadius(25/2)
                    }
             
                Text(category.name!)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                }
                .fixedSize()
                Spacer()
                StringColorConverter().colorFor(colorName: category.colorName!)
                    .frame(width: 25, height: 25)
                    .cornerRadius(25/2)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 10))
            }
            }
           
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                if selectedCatoryName == category.name! {
                    selectedCatoryName = "Category"
                } else {
                    selectedCatoryName = category.name!
                }
            }
        }
    }
}


