//
//  AddBudgetGoal.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-30.
//

import SwiftUI


struct AddBudgetGoal: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ExpenseCategory.name, ascending: true)],
        animation: .default)
    
    private var categories: FetchedResults<ExpenseCategory>
    
    @Binding var budgetGoals: [TempBudgetGoals]
    @State var amount: String = ""
    @State var selectedCategoryName = ""
    
    var body: some View {
        GeometryReader { geometry in
                VStack {
                    Spacer()
                    TextFieldView(textInput: $amount, holderText: "Amount")
                    ExpenseCategoryListView(selectedCategoryName: $selectedCategoryName)
                        .frame(height: geometry.size.height/2)
                    Button {
                    saveBudgetGoal()
                    } label: {
                        SaveButtonView(color: Color.green)
                    }
                    Spacer()
                }
                .frame(alignment: .center)
            .navigationTitle(Text("New goal"))
        }
    }
    
    private func saveBudgetGoal() {
        //TODO: Fix check that the string actually is a possible double value
       
        //TODO: Fix so that we do not have to loop through all of the categories
        for category in categories {
            if category.name! == selectedCategoryName {
                budgetGoals.append(TempBudgetGoals(amount: Double(amount) ?? 0, category: category))
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct AddBudgetGoal_Previews: PreviewProvider {
    static var previews: some View {
        AddBudgetGoal(budgetGoals: .constant([]))
    }
}
