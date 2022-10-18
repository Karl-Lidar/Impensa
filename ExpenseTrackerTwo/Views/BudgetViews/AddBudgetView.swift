//
//  AddBudgetView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-30.
//

import SwiftUI

struct TempBudgetGoals: Hashable {
    var amount: Double
    var category: ExpenseCategory
}

struct AddBudgetView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var budgetName = ""
    @State var budgetGoals: [TempBudgetGoals] = []
    
    var body: some View {
        GeometryReader { geometry in
                VStack {
                    Spacer()
                    TextFieldView(textInput: $budgetName, holderText: "Budget name")
                   BudgetGoalsListView(budgetGoals: $budgetGoals)
                    .frame(height: geometry.size.height/2)
                    Button {
                       saveBudget()
                    } label: {
                        SaveButtonView(color: Color.green)
                    }
                    Spacer()
                }
                .frame(alignment: .center)
            .navigationTitle(Text("New budget"))
        }
    }
    
    private func saveBudget() {
        let coreDataManager = CoreDataManager(context: viewContext)
        coreDataManager.coreDataBudgetManager.createbudgetTable(budgetName: budgetName, budgetGoals: budgetGoals)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        AddBudgetView()
    }
}
