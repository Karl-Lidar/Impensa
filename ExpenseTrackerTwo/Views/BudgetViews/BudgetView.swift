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
                                Section(header:
                                            HStack {
                                            Text(budgetTable.name!)
                                    .font(Font.system(size: 30))
                                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                    Spacer()
                                    NavigationLink(destination: AddBudgetView(budgetName: budgetTable.name!, budgetGoals: createTempBudgetGoalsFromExisitingBudget(budget: budgetTable), alreadyExistingBudgetTable: budgetTable, mode: .Update)) {
                                       BudgetSettingButton()
                                            .customShadow()
                                    }
                                    .padding()
                                    
                                   
                                
                                }) {
                                        ForEach(budgetTable.wrappedBudgetGoal) { budgetGoal in
                                            NavigationLink(destination: ExpensesView(filterActive: true, budgetName: budgetTable.name!, categoryName: budgetGoal.expenseCategory!.name!)) { ZStack {
                                                BudgetGoalView(filterValue: budgetGoal.expenseCategory!, budgetGoal: budgetGoal, budgetTable: budgetTable)
                                                    .frame(width: geometry.size.width/1.4, height: 80)
                                            } }
                                        }
                                    }
                            }
                        }
                        Spacer()
                    }
                }
                .navigationTitle(Text("Budgets"))
                .toolbar {
                    NavigationLink {
                        AddBudgetView(mode: .Save)
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.green)
                    }

                }
            }
        }
    }
    
    private func createTempBudgetGoalsFromExisitingBudget(budget: BudgetTable) -> [TempBudgetGoals] {
        
        var tempBudgetGoals: [TempBudgetGoals] = []
        for goal in budget.wrappedBudgetGoal {
            
            tempBudgetGoals.append(TempBudgetGoals(amount: goal.goalAmount, category: goal.expenseCategory!, id: goal.id!))
        }
        return tempBudgetGoals
    }
}

struct BudgetView_Previews: PreviewProvider {
   
    static var previews: some View {
        
        BudgetView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
