//
//  ContentView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-07.
//

//TODO: Imorgon, lägg in så att vi kan filterara på project och category för att skapa varje rad i budgetGoalView

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
  
    @State var addExpense = false
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemGray6
    }
     
    
    var body: some View {
   
        TabView {
            
           HomeView()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Add")
                }
             
            BudgetView()
                .tabItem {
                    Image(systemName: "pencil")
                    Text("Budgets")
                }
            
            ExpensesView(filterActive: false, budgetName: "NoName", categoryName: "NoName")
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Expenses")
                }
            
            CategoriesView()
                .tabItem {
                    Image(systemName: "tag")
                    Text("Categories")
                }
        }
        .accentColor(Color.green.opacity(0.8))
        
         
    }
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}

/*
private func addItem() {
    withAnimation {
        let newItem = BudgetTable(context: viewContext)
        newItem.timestamp = Date()

        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
 */

/*
 
 /*
 NavigationView {
     GeometryReader { geometry in
         if items.count != 0 {
             
             ForEach(items) { item in
                 VStack {
                     HStack {
                         Spacer()
                         BudgetView(budgetName: item.name!, coreDataGoals: item.wrappedBudgetGoal)
                             .frame(width: geometry.size.width/1.2)
                             .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 5)

                         Spacer()
                     }
                     Spacer()
                 }
             }
             
         } else {
             Button {
                 addBudgetTable()
             } label: {
               Text("Add table")
             }
         }
     }
 }
 .onAppear {
     //Generates if no categories exist
     if expenseCategories.count == 0 {
     generateExpenseCategories()
     }
 }
 .sheet(isPresented: $addExpense) {
     AddExpenseView()
 }
 */
    func deleteGoal(budgetTable: BudgetTable) {
    
        viewContext.delete(budgetTable.wrappedBudgetGoal[0])
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
     */
