//
//  ExpenseInfoView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-17.
//

import SwiftUI

struct ExpenseInfoView: View {
    
    @ObservedObject var expense: Expense
    @ObservedObject var expenseCategory: ExpenseCategory
    
    var body: some View {
            HStack {
                Text(expense.name!)
                    .foregroundColor(Color.black)
                Spacer()
                ZStack {
                    StringColorConverter().colorFor(colorName: expenseCategory.colorName!)
                        .opacity(0.8)
                        .frame(height: 30)
                        .cornerRadius(30/2)
                Text("\(String(expense.amount))")
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                .fixedSize()
            }
        }
}

struct ExpenseInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseInfoView(expense: PreviewManager(viewContext: PersistenceController.preview.container.viewContext).getSingleExpense(), expenseCategory: PreviewManager(viewContext: PersistenceController.preview.container.viewContext).getSingleExpense().expenseCategory!).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
