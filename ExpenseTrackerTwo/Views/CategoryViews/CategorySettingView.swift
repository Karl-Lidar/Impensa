//
//  CategorySettingView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-21.
//

import SwiftUI

struct CategorySettingView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    var stringColors = ["Red": Color.red, "Green": Color.green, "Blue": Color.blue, "Brown": Color.brown, "Yellow": Color.yellow, "Pink": Color.pink, "Purple": Color.purple, "Gray": Color.gray, "Cyan": Color.cyan, "Indigo": Color.indigo, "Orange": Color.orange, "Mint": Color.mint]
    
    @State var categoryColor = Color.green
    @State var categoryName = ""
    
    var shouldCreateNewCategory: Bool?
    var expenseCategory: ExpenseCategory?
    
    init(expenseCategory: ExpenseCategory) {
        self.expenseCategory = expenseCategory
    }
    
    init() {
        
    }

    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                Spacer()
                        TextFieldView(textInput: $categoryName, holderText: "Name")
                CategoryColorBox(categoryColor: $categoryColor)
                HStack {
                    Spacer()
                    Button {
                        if updateMode() {
                            updateCategory(expenseCategory: expenseCategory!, categoryName: categoryName, color: categoryColor)
                        } else {
                            saveCategory(name: categoryName, color: categoryColor)
                        }
                    } label: {
                        SaveButtonView(color: Color.green)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .navigationTitle(Text("Category setting"))
        }
        .onAppear {
            setOnAppearVariables()
        }
    }
}

struct CategorySettingView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySettingView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

extension CategorySettingView {
    
    private func setOnAppearVariables() {
        guard let category = expenseCategory else {
            self.categoryName = ""
            self.categoryColor = Color.green
            return
        }
        
        categoryName = expenseCategory!.name!
        categoryColor = StringColorConverter().colorFor(colorName: expenseCategory!.colorName!)
    }
    
    //Returns a bool depending upon if user is updating a existing c
    func updateMode() -> Bool {
        guard let category = expenseCategory else {
            return false
        }
        return true
    }
    
    private func saveCategory(name: String, color: Color) {
        CoreDataManager(context: viewContext).expenseCategoryCoreDataManager.createNewExpenseCategory(name: categoryName, color: StringColorConverter().stringFor(color: categoryColor))
    }
    
    private func updateCategory(expenseCategory: ExpenseCategory, categoryName: String, color: Color) {
        CoreDataManager(context: viewContext).expenseCategoryCoreDataManager.updateExpenseCategory(expenseCategory: expenseCategory, name: categoryName, color: StringColorConverter().stringFor(color: color))
    }
}

