//
//  AddExpenseView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-07.
//

import SwiftUI

struct AddExpenseView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BudgetTable.name, ascending: true)],
        animation: .default)
    private var budgetTable: FetchedResults<BudgetTable>
    
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ExpenseCategory.name, ascending: true)],
        animation: .default)
    private var expenseCategories: FetchedResults<ExpenseCategory>
    
    @State var expenseName: String = ""
    @State var amountString: String = ""
    @State var selectedCatoryName: String = ""
    @State var selectedBudgetName: String = ""
    @State var currentPage = 1
    
    var body: some View {
        
        //TODO: Kolla upp transistion in och ut. Möjligtvis
        let customTransition = AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)).combined(with: .opacity)
        
        GeometryReader { geometry in
            
            ZStack {
                BackgroundSplashView(multiplier: 1.3, color: Color.green)
            if currentPage == 1 {
                VStack {
                    Spacer()
                AddExpenseTextInputView(currentAddExpensePage: $currentPage, expenseName: $expenseName, amountString: $amountString, withSaveButton: true)
                        .frame(height: 200)
                    
                    Spacer()
                }
                .transition(customTransition)
               
            }
            
            if currentPage == 2 {
                VStack {
                    Spacer()
                PickExpenseCategoryView(selectedCatoryName: $selectedCatoryName, currentAddExpensePage: $currentPage, withSaveButton: true)
                    .frame(height: geometry.size.height/2)
                  
                    Spacer()
                }
                .transition(customTransition)
            }
            
            if currentPage == 3 {
                VStack {
                    Spacer()
                PickBudgetTableView(selectedBudgetName: $selectedBudgetName)
                        .frame(height: geometry.size.height/2)
                  
                    
                    Button {
            saveExpense()
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        SaveButtonView(color: Color.green)
                    }
                    Spacer()
                }
                .transition(customTransition)
            }
            }
               
        }
        .navigationTitle(Text("Add expense"))
       
    }
    
    private func saveExpense() {
                    let coreDataManager = CoreDataManager(context: viewContext)
        //TODO: Fix for
        
        var pickedExpenseCategory: ExpenseCategory?
        var pickedBudgetTable: BudgetTable?
        
        //Find the correct ExpenseCategory
        for category in expenseCategories {
            if category.name! == selectedCatoryName {
                pickedExpenseCategory = category
            }
        }
        
        for budget in budgetTable {
            if budget.name! == selectedBudgetName {
                pickedBudgetTable = budget
            }
        }
        
        coreDataManager.coreDataExpenseManager.createNewExpense(expenseName: expenseName, expenseAmount: Double(amountString)!, expenseCategory: pickedExpenseCategory!, budgetTable: pickedBudgetTable!)
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
    }
}
