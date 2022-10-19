//
//  AddExpenseTextInputView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-02.
//

import SwiftUI

struct AddExpenseDataView: View {
    
    //ENVIRONMENT
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    //FETCHED DATA
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BudgetTable.name, ascending: true)],
        animation: .default)
    private var budgetTable: FetchedResults<BudgetTable>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ExpenseCategory.name, ascending: true)],
        animation: .default)
    private var expenseCategories: FetchedResults<ExpenseCategory>

    //OPEN VIEW STATES
    @Binding var openPickCategoryView: Bool
    @Binding var openPickBudgetView: Bool
    @Binding var openPickDateView: Bool
    
    //EXPENSE DATA INPUTS
    @Binding var expenseName: String
    @Binding var amountString: String
    @Binding var selectedCategoryName: String
    @Binding var selectedBudgetName: String
    @Binding var selectedExpenseDate: Date
    
    //USER INTERFACE
    @Binding var blurView: Bool
    @Binding var currentCategoryColor: Color
    @State var withSaveButton: Bool
    
    //CUSTOM TRANSITION
    let slideInSlideOut = AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing))

    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Spacer()
                    AddExpenseTextInputView(textInput: $expenseName, holderText: "Expense name")
                        .frame(width: geometry.size.width/1.5)
                    
                    AddExpenseTextInputView(textInput: $amountString, holderText: "Amount (kr)")
                        .frame(width: geometry.size.width/1.5)
                    
                    AddExpenseListTextView(selectedNameFromList: $selectedCategoryName, openListView: $openPickCategoryView, activateBlurView: $blurView)
                        .frame(width: geometry.size.width/1.5)
                    
                    AddExpenseListTextView(selectedNameFromList: $selectedBudgetName, openListView: $openPickBudgetView, activateBlurView: $blurView)
                        .frame(width: geometry.size.width/1.5)
                    
                    if withSaveButton == true {
                        HStack {
                            Spacer()
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                           saveExpenseToCoreData()
                        } label: {
                            SaveButtonView(color: currentCategoryColor)
                        }

                            AddExpenseCalendarButton(openPickDateView: $openPickDateView, blurView: $blurView, currentCategoryColor: $currentCategoryColor)
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    }
                }  
            }
        }
    }
    
    //FUNCTIONS
    private func saveExpenseToCoreData() {
        let coreDataManager = CoreDataManager(context: viewContext)
        
        //Find correct expensCategory
        var expenseCategoryForManager: ExpenseCategory?
        //TODO: Make this search of categories better
        for category in expenseCategories {
            if selectedCategoryName == category.name! {
                expenseCategoryForManager = category
                break
            }
        }
        
        //Find correct budget
        var budgetTableForManager: BudgetTable?
        //TODO: Make this search of budgets better
        for budget in budgetTable {
            if selectedBudgetName == budget.name! {
                budgetTableForManager = budget
            }
        }
        
        //TODO: Make sure name is given
        //TODO: Make sure amount is a double and not a string
        //TODO: Make sure category selected
        //TODO: Make sure budget is selected
        
        //Basic safety for click in save button
        if selectedBudgetName != "Budget" && selectedCategoryName != "Category" && amountString != "" && expenseName != ""{
            coreDataManager.coreDataExpenseManager.createNewExpense(expenseName: expenseName, expenseAmount: Double(amountString)!, expenseCategory: expenseCategoryForManager!, budgetTable: budgetTableForManager!, date: selectedExpenseDate)
        }
    }
}


