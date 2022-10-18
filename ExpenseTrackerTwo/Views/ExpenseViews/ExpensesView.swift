//
//  ExpensesView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-15.
//

import SwiftUI

struct ExpensesView: View {

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Expense.name, ascending: true)],
        animation: .default)
    
    private var expenses: FetchedResults<Expense>
    
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    List {
                    ForEach(expenses) { expense in
                        NavigationLink(destination: ExpenseSettingView(amountString: String(expense.amount), expenseName: expense.name!, selectedCatoryName: expense.expenseCategory!.name!, selectedBudgetName: expense.budget!.name!, expense: expense)) {
                            ExpenseInfoView(expense: expense)
                        }
                    }
                    }
            }
                .navigationTitle(Text("Expenses"))
            }
        }
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
        ExpensesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
 
