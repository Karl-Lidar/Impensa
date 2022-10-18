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
                                
                                NavigationLink(destination: CategorySettingView(expenseCategory: category)) { HStack {
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
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            NavigationLink(destination: CategorySettingView()) { ZStack {
                                Color.green
                                    .frame(width: geometry.size.width/6, height: geometry.size.width/6)
                                    .cornerRadius(geometry.size.width/12)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                                Image(systemName: "plus")
                                    .foregroundColor(Color.white)
                            } }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 30))
                        }
                    }
                }
                .navigationTitle("Categories")
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

