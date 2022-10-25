//
//  CategoriesView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-21.
//

import SwiftUI

struct CategoriesView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ExpenseCategory.name, ascending: true)],
        animation: .default)
    private var expenseCategories: FetchedResults<ExpenseCategory>
    
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    VStack {
                        List {
                            ForEach(expenseCategories) { category in
                                NavigationLink(destination: CategorySettingView(expenseCategory: category, saveOrUpdateMode: .Update)) { HStack {
                                    Text(category.name!)
                                        .foregroundColor(Color.black)
                                    Spacer()
                                    StringColorConverter().colorFor(colorName: category.colorName!)
                                        .opacity(0.8)
                                        .frame(width: 30, height: 30)
                                        .cornerRadius(30/2)
                                }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Categories")
                .toolbar {
                    
                    NavigationLink {
                        CategorySettingView()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.green)
                    }
                }
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

