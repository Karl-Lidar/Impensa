//
//  AddExpenseTextInputView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-02.
//

import SwiftUI

struct AddExpenseDataView: View {
    
    struct ExpenseInputs {
        var allInputsValid: Bool
        var expenseCategory: ExpenseCategory
        var budgetTable: BudgetTable
        var expenseName: String
        var expenseAmount: Double
        var expenseDate: Date
        var expense: Expense?
    }
    
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
    
    var addExpenseMode: AddExpenseMode
    
    var alreadyExistingExpense: Expense?
    @Binding var openDeleteAlert: Bool
    

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
                          //  CoreDataManager(context: viewContext).coreDataExpenseManager.deleteExpense(expense: alreadyExistingExpense!)
                           completeButtonTouched(addExpenseMode: addExpenseMode)
                        } label: {
                            SaveButtonView(color: currentCategoryColor, saveOrUpdate: saveOrUpdateText(addExpenseMode: addExpenseMode))
                        }

                            AddExpenseCalendarButton(openPickDateView: $openPickDateView, blurView: $blurView, currentCategoryColor: $currentCategoryColor)
                            
                            if addExpenseMode == .Update {
                                AddExpenseDeleteButton(currentCategoryColor: $currentCategoryColor, openDeleteAlert: $openDeleteAlert)
                            }
                           
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    }
                }  
            }
        }
       
    }
    
    //FUNCTIONS
    private func completeButtonTouched(addExpenseMode: AddExpenseMode) {
        self.presentationMode.wrappedValue.dismiss()
        
        if addExpenseMode == .Save {
            saveExpenseToCoreData()
        } else {
            updateExpenseInCoreData()
        }
       
    }
    
    private func saveOrUpdateText(addExpenseMode: AddExpenseMode) -> SaveOrUpdate {
        if addExpenseMode == .Save {
            return .Save
        } else {
            return .Update
        }
    }
    
    private func checkAndGetAllInputs() -> ExpenseInputs  {
        
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
        
        
        if selectedBudgetName != "Budget" && selectedCategoryName != "Category" && amountString != "" && expenseName != "" {
            if addExpenseMode == .Save {
                return ExpenseInputs(allInputsValid: true, expenseCategory: expenseCategoryForManager!, budgetTable: budgetTableForManager!, expenseName: expenseName, expenseAmount: Double(amountString)!, expenseDate: selectedExpenseDate)
            } else {
                return ExpenseInputs(allInputsValid: true, expenseCategory: expenseCategoryForManager!, budgetTable: budgetTableForManager!, expenseName: expenseName, expenseAmount: Double(amountString)!, expenseDate: selectedExpenseDate, expense: alreadyExistingExpense!)
            }
            
        } else {
            return ExpenseInputs(allInputsValid: false, expenseCategory: expenseCategoryForManager!, budgetTable: budgetTableForManager!, expenseName: "Default", expenseAmount: Double(1000.0), expenseDate: Date())
        }
    }
    
    private func updateExpenseInCoreData() {
        let coreDataManager = CoreDataManager(context: viewContext)
        let userInputs = checkAndGetAllInputs()
        if userInputs.allInputsValid == true {
            
            coreDataManager.coreDataExpenseManager.updateExpense(expenseName: userInputs.expenseName, expenseAmount: userInputs.expenseAmount, expenseCategory: userInputs.expenseCategory, budgetTable: userInputs.budgetTable, date: userInputs.expenseDate, expenseToUpdate:userInputs.expense! )
             
        }
    }
    
    private func saveExpenseToCoreData() {
        let coreDataManager = CoreDataManager(context: viewContext)
        
        let userInputs = checkAndGetAllInputs()
        
        //TODO: Make sure name is given
        //TODO: Make sure amount is a double and not a string
        //TODO: Make sure category selected
        //TODO: Make sure budget is selected
        
        if userInputs.allInputsValid == true {
            coreDataManager.coreDataExpenseManager.createNewExpense(expenseName: userInputs.expenseName, expenseAmount: userInputs.expenseAmount, expenseCategory: userInputs.expenseCategory, budgetTable: userInputs.budgetTable, date: userInputs.expenseDate)
        }
        
        //Basic safety for click in save button
        
    }
}


