//
//  BudgetTableListView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-02.
//

import SwiftUI

struct BudgetTableListView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BudgetTable.name, ascending: true)],
        animation: .default)
    private var budgetTables: FetchedResults<BudgetTable>
    
    @Binding var selectedCategoryName: String
    
    var body: some View {
        List {
            ForEach(budgetTables) { budgetTable in
                BudgetTableListObject(selectedBudgetName: $selectedCategoryName, budgetTable: budgetTable)
            }
            /*
            NavigationLink(destination: CategorySettingView()) {
                ListViewLinkButton(buttonName: "New category", buttonHeight: 25)
            }
             */
        }
        .padding()
        .cornerRadius(25)
    }
}

