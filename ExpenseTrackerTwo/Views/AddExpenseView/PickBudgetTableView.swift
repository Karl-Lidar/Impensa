//
//  PickBudgetTableView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-02.
//

import SwiftUI

struct PickBudgetTableView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var selectedBudgetName: String
    
    var body: some View {
        GeometryReader { geometry in
            
            BudgetTableListView(selectedCategoryName: $selectedBudgetName)
               // .frame(height: geometry.size.height/2)
            
        }
        
    }
}
