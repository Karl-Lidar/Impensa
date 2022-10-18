//
//  BudgetView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-07.
//

import SwiftUI

struct BudgetView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Expense.name, ascending: true)],
        animation: .default)
    
    private var expenses: FetchedResults<Expense>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BudgetTable.name, ascending: true)],
        animation: .default)
    
    private var budgetTables: FetchedResults<BudgetTable>
    
    var body: some View {
        
        GeometryReader { geometry in
            
            NavigationView {
                ZStack {
                    HStack {
                        Spacer()
                        List {
                            ForEach(budgetTables) { budgetTable in
                                Section(header: Text(budgetTable.name!)
                                    .font(Font.system(size: 30))
                                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))) {
                                        
                                        ForEach(budgetTable.wrappedBudgetGoal) { budgetGoal in
                                            BudgetGoalView(filterValue: budgetGoal.expenseCategory!, budgetGoal: budgetGoal, budgetTable: budgetTable)
                                                .frame(width: geometry.size.width/1.4, height: 80)
                                        }
                                    }
                            }
                        }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        VStack {
                            Spacer()
                            NavigationLink(destination: AddBudgetView()) { ZStack {
                               GreenPlusButton()
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                            } }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 30))
                        }
                    }
                    
                }
                .navigationTitle(Text("Budgets"))
            }
        }
    }
}

struct BudgetView_Previews: PreviewProvider {
   
    static var previews: some View {
        
        BudgetView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
