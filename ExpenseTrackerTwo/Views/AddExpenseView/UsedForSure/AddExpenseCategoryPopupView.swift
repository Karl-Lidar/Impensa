//
//  AddExpenseCategoryPopupView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-18.
//

import SwiftUI

struct AddExpenseCategoryPopupView: View {
    
    //TODO: Pass the other from the other view rather then fethcing again
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ExpenseCategory.name, ascending: true)],
        animation: .default)
    private var expenseCategories: FetchedResults<ExpenseCategory>
    
    @Binding var selectedCategoryName: String
    @Binding var showCategories: Bool
    @Binding var blurView: Bool
    @Binding var currentCategoryColor: Color
    
    var body: some View {
        
        ZStack {
            Color(UIColor.systemGray6)
                .frame(width: 250, height: 430, alignment: .center)
            
            VStack {
                ExpenseCategoryListView(selectedCategoryName: $selectedCategoryName)
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
                        showCategories.toggle()
                        blurView.toggle()
                        currentCategoryColor = colorForCategory(name: selectedCategoryName)
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
    
    func colorForCategory(name: String) -> Color {
        
        if name == "" {
            return Color.green
        } else {
            
            for cateogry in expenseCategories {
                if cateogry.name! == name {
                    return StringColorConverter().colorFor(colorName: cateogry.colorName!)
                }
            }
        }
        return Color.green
    }
}

struct AddExpenseCategoryPopupView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseCategoryPopupView(selectedCategoryName: .constant("Category"), showCategories: .constant(false), blurView: .constant(false), currentCategoryColor: .constant(Color.green))
    }
}
