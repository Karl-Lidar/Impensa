//
//  ExpensesView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-15.
//

import SwiftUI

struct ExpensesView: View {

    @FetchRequest var fetchRequestExpense: FetchedResults<Expense>
    @Environment(\.managedObjectContext) private var viewContext
    
    //private var expenses: FetchedResults<Expense>
    @State var openDeleteAlert = false
    @State var expenseToDelete = Expense()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ExpenseCategory.name, ascending: true)],
        animation: .default)
    
    private var expenseCategories: FetchedResults<ExpenseCategory>
    var embeddedInNavigationView: Bool
    
    init(filterActive: Bool, budgetName: String, categoryName: String) {
        if filterActive == false {
            _fetchRequestExpense = FetchRequest<Expense>(sortDescriptors: [NSSortDescriptor(keyPath: \Expense.name, ascending: true)])
            self.embeddedInNavigationView = true
        } else {
            
            _fetchRequestExpense = FetchRequest<Expense>(sortDescriptors: [NSSortDescriptor(keyPath: \Expense.name, ascending: true)], predicate: NSPredicate(format: "budget.name = %@ && expenseCategory.name = %@", budgetName, categoryName))
            self.embeddedInNavigationView = false
        }
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            if embeddedInNavigationView == true {
            NavigationView {
                VStack {
                    List {
                    ForEach(fetchRequestExpense) { expense in
                     
                        NavigationLink(destination:
                        
                                        AddExpenseView(expenseName: expense.name!, amountString: "\(expense.amount)", selectedBudgetName: expense.budget!.name!, selectedCategoryName: expense.expenseCategory!.name!, selectedExpenseDate: expense.date!, backgroundSplashColor: StringColorConverter().colorFor(colorName: expense.expenseCategory!.colorName!), addExpenseMode: .Update, alreadyExistingExpense: expense, expenseToDelete: $expenseToDelete)
                                       
                        ) {
                            HStack {
                                Text(expense.name!)
                                    .foregroundColor(Color.black)
                                Spacer()
                                ZStack {
                                    StringColorConverter().colorFor(colorName: expense.expenseCategory!.colorName!)
                                        .opacity(0.8)
                                        .frame(height: 30)
                                        .cornerRadius(30/2)
                                Text("\(String(expense.amount))")
                                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                }
                                .fixedSize()
                            }
                                .contextMenu {
                                    Button {
                                        CoreDataManager(context: viewContext).coreDataExpenseManager.deleteExpense(expense: expense)
                                    } label: {
                                        HStack {
                                           Text("Delete")
                                            Spacer()
                                            Image(systemName: "trash.fill")
                                        }
                                        .padding()
                                    }
                                }
                        }
                        
                    }
                    }
                    
            }
                .navigationTitle(Text("Expenses"))
                .toolbar {
                    NavigationLink {
                        AddExpenseView(addExpenseMode: .Save, expenseToDelete: $expenseToDelete)
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.green)
                    }
                }
            }
            } else {
                    VStack {
                        List {
                        ForEach(fetchRequestExpense) { expense in
                        
                         
                            
                            //1. Testa att använda contextmenu för delete
                            //2. Testa att använda contextmenu med openAlertButton
                            //3. Testa om det är de två listorna som är problemet

                           
                                
                            
                            NavigationLink(destination:
                            
                                            AddExpenseView(expenseName: expense.name!, amountString: "\(expense.amount)", selectedBudgetName: expense.budget!.name!, selectedCategoryName: expense.expenseCategory!.name!, selectedExpenseDate: expense.date!, backgroundSplashColor: StringColorConverter().colorFor(colorName: expense.expenseCategory!.colorName!), addExpenseMode: .Update, alreadyExistingExpense: expense, expenseToDelete: $expenseToDelete)
                                           
                            ) {
                                /*
                                ExpenseInfoView(expense: expense, expenseCategory: getExpenseCategoryForExpense(expenseCategories: expenseCategories, expense: expense))
                                 */
                                HStack {
                                    Text(expense.name!)
                                        .foregroundColor(Color.black)
                                    Spacer()
                                    ZStack {
                                        StringColorConverter().colorFor(colorName: expense.expenseCategory!.colorName!)
                                            .opacity(0.8)
                                            .frame(height: 30)
                                            .cornerRadius(30/2)
                                    Text("\(String(expense.amount))")
                                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                    }
                                    .fixedSize()
                                }
                                    .contextMenu {
                                        Button {
                                           // CoreDataManager(context: viewContext).coreDataExpenseManager.deleteExpense(expense: expense)
                                            expenseToDelete = expense
                                            openDeleteAlert.toggle()
                                        } label: {
                                            Text("Delete")
                                        }

                                    }
                        }
                            
                            
                        }
                        }
                }
                   
                    .navigationTitle(Text("Expenses"))
                    .toolbar {
                        NavigationLink {
                            AddExpenseView(addExpenseMode: .Save, expenseToDelete: $expenseToDelete)
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(Color.green)
                        }
                    }
            }
        }
        .alert(isPresented: $openDeleteAlert) {
            Alert(title: Text("Delete expense"), message: Text("Are you sure about this?"), primaryButton: .default(Text("Delete"), action: {
                CoreDataManager(context: viewContext).coreDataExpenseManager.deleteExpense(expense: expenseToDelete)
              
            }), secondaryButton: .default(Text("Go back")))
        }
    }
    
    private func getExpenseCategoryForExpense(expenseCategories: FetchedResults<ExpenseCategory>, expense: Expense) -> ExpenseCategory {
        
        for category in expenseCategories {
            if expense.expenseCategory!.name! == category.name! {
                return category
            }
        }
        
        //TODO: Not good but should not get here anyway, maybe?
        return ExpenseCategory()
    }
    
    /*
    init(filterValues: [ExpenseCategory]) {
        
        /*
        _fetchRequest = FetchRequest<Expense>(sortDescriptors: [NSSortDescriptor(keyPath: \Expense.name, ascending: true)], predicate: NSPredicate(format: "expenseCategory IN %@", filterValues))
         */
        
        
        _fetchRequest = FetchRequest<Expense>(sortDescriptors: [NSSortDescriptor(keyPath: \Expense.name, ascending: true)], predicate: NSPredicate(format: "expenseCategory IN %@", filterValues))
    }
     */
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView(filterActive: false, budgetName: "BudgetName", categoryName: "NoName").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
 
