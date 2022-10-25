//
//  AddExpenseView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-07.
//

import SwiftUI

enum AddExpenseMode {
    case Save
    case Update
}

struct AddExpenseView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext

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
    @State var openPickCategoryView = false
    @State var openPickBudgetView = false
    @State var openPickDateView = false
    
    //EXPENSE DATA INPUTS
    @State var expenseName: String = ""
    @State var amountString: String = ""
    @State var selectedBudgetName: String = "Budget"
    @State var selectedCategoryName = "Category"
    @State var selectedExpenseDate = Date()
    
    //USER INTERFACE
    @State var blurView = false
    @State var backgroundSplashColor = Color.green

    //CUSTOM TRANSITION
    let slideInSlideOut = AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .scale(scale: 0.1)).combined(with: .opacity)
    
    var addExpenseMode: AddExpenseMode
    
    var alreadyExistingExpense: Expense?
    @Binding var expenseToDelete: Expense
    
    @State var openDeleteAlert = false
    
    var body: some View {
        
        //TODO: Kolla upp transistion in och ut. Möjligtvis
        let customTransition = AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)).combined(with: .opacity)
        
        GeometryReader { geometry in
            ZStack {
                    BackgroundSplashView(multiplier: 1.3, color: backgroundSplashColor)
                   .blur(radius: blurView ? 15 : 0)
               
                if addExpenseMode == .Save {
                    AddExpenseDataView(openPickCategoryView: $openPickCategoryView, openPickBudgetView: $openPickBudgetView, openPickDateView: $openPickDateView, expenseName: $expenseName, amountString: $amountString, selectedCategoryName: $selectedCategoryName, selectedBudgetName: $selectedBudgetName, selectedExpenseDate: $selectedExpenseDate, blurView: $blurView, currentCategoryColor: $backgroundSplashColor, withSaveButton: true, addExpenseMode: addExpenseMode, openDeleteAlert: $openDeleteAlert)
                        .frame(height: 400)
                        .blur(radius: blurView ? 15 : 0)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 80, trailing: 0))
                } else {
                    
                    AddExpenseDataView(openPickCategoryView: $openPickCategoryView, openPickBudgetView: $openPickBudgetView, openPickDateView: $openPickDateView, expenseName: $expenseName, amountString: $amountString, selectedCategoryName: $selectedCategoryName, selectedBudgetName: $selectedBudgetName, selectedExpenseDate: $selectedExpenseDate, blurView: $blurView, currentCategoryColor: $backgroundSplashColor, withSaveButton: true, addExpenseMode: addExpenseMode, alreadyExistingExpense: alreadyExistingExpense!, openDeleteAlert: $openDeleteAlert)
                            .frame(height: 400)
                            .blur(radius: blurView ? 15 : 0)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 80, trailing: 0))
                }
                
                //PICK CATEGORY VIEW
                if openPickCategoryView == true {
                    AddExpenseCategoryPopupView(selectedCategoryName: $selectedCategoryName, showCategories: $openPickCategoryView, blurView: $blurView, currentCategoryColor: $backgroundSplashColor)
                        .customShadow()
                        .transition(slideInSlideOut)
                }
                
                //PICK BUDGET VIEW
                if openPickBudgetView == true {
                    AddExpenseBudgetPopupView(selectedBudgetName: $selectedBudgetName, showBudgets: $openPickBudgetView, blurView: $blurView, currentCategoryColor: $backgroundSplashColor)
                        .customShadow()
                        .transition(slideInSlideOut)
                }
                
                //PICK DATE VIEW
                if openPickDateView == true {
                    AddExpenseDatePicker(date: $selectedExpenseDate, openDatePicker: $openPickDateView, blurView: $blurView, currentCategoryColor: $backgroundSplashColor)
                        .customShadow()
                        .transition(slideInSlideOut)
                }
            }
        }
        .onAppear {
            if addExpenseMode == .Update {
                expenseToDelete = alreadyExistingExpense!
            }
        }
        .alert(isPresented: $openDeleteAlert) {
            Alert(title: Text("Delete expense"), message: Text("Are you sure about this?"), primaryButton: .default(Text("Delete"), action: {
                
                self.presentationMode.wrappedValue.dismiss()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    CoreDataManager(context: viewContext).coreDataExpenseManager.deleteExpense(expense: expenseToDelete)
                }
                
                
              
            }), secondaryButton: .default(Text("Go back")))
        }
        .ignoresSafeArea(.keyboard)
        .navigationTitle(Text("Add expense"))
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        //TODO: This need to be fixed
        AddExpenseView(selectedCategoryName: "CatreogyrName", addExpenseMode: .Save, expenseToDelete: .constant(Expense()))
    }
}
