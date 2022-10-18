//
//  PickExpenseCategoryView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-02.
//

import SwiftUI

struct PickExpenseCategoryView: View {
    
    var expensePageNumber = 2
    @Binding var selectedCatoryName: String
    @Binding var currentAddExpensePage: Int
    @State var withSaveButton: Bool
    
    
    var body: some View {
        GeometryReader { geometry in
          
            HStack {
                Spacer()
            VStack {
                    ExpenseCategoryListView(selectedCategoryName: $selectedCatoryName)
                    .frame(width: geometry.size.width/1.5)
                        //.frame(height: geometry.size.height/2)
                    if withSaveButton {
                    Button {
                        withAnimation {
                            currentAddExpensePage = expensePageNumber+1
                        }
                    } label: {
                        SaveButtonView(color: Color.green)
                    }
                    }
            }
                Spacer()
            }
        }
    }
}

