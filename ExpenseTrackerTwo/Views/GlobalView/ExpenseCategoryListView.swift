//
//  ExpenseCategoryListView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-01.
//

import SwiftUI

struct ExpenseCategoryListView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ExpenseCategory.name, ascending: true)],
        animation: .default)
    private var expenseCategories: FetchedResults<ExpenseCategory>
    
    @Binding var selectedCategoryName: String
    
    var body: some View {
        List {
            ForEach(expenseCategories) { category in
                AddExpenseViewCategoryButton(selectedCatoryName: $selectedCategoryName, category: category)
                    
            }
            NavigationLink(destination: CategorySettingView()) {
                ListViewLinkButton(buttonName: "New category", buttonHeight: 25)
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}
