//
//  CategorySettingView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-21.
//

import SwiftUI

enum SaveOrUpdateMode {
case Save
    case Update
}

struct CategorySettingView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var stringColors = ["Red": Color.red, "Blue": Color.blue, "Brown": Color.brown, "Yellow": Color.yellow, "Pink": Color.pink, "Purple": Color.purple, "Gray": Color.gray, "Cyan": Color.cyan, "Indigo": Color.indigo, "Orange": Color.orange, "Mint": Color.mint]
    
    @State var categoryColor = Color.green
    @State var categoryName = ""
    
    var shouldCreateNewCategory: Bool?
    var expenseCategory: ExpenseCategory?
    
    var saveOrUpdateMode: SaveOrUpdateMode?
    
    @State var openDeleteAlert = false
    @State var openDeleteAlertTwo = false
    
    init(expenseCategory: ExpenseCategory, saveOrUpdateMode: SaveOrUpdateMode) {
        self.expenseCategory = expenseCategory
        self.saveOrUpdateMode = saveOrUpdateMode
        
    }
    
    init() {
        self.saveOrUpdateMode = .Save
    }

    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                BackgroundSplashView(multiplier: 1.3, color: categoryColor)
            VStack {
                Spacer()
                TextFieldView(textInput: $categoryName, holderText: "Name", textFieldDividerSize: .Small)
                CategoryColorBox(categoryColor: $categoryColor)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                HStack {
                    Spacer()
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                        if updateMode() {
                            updateCategory(expenseCategory: expenseCategory!, categoryName: categoryName, color: categoryColor)
                        } else {
                            saveCategory(name: categoryName, color: categoryColor)
                        }
                    } label: {
                        SaveButtonView(color: categoryColor, saveOrUpdate: saveOrUpdateMode(saveOrUpdate: saveOrUpdateMode!))
                    }
                    
                    if saveOrUpdateMode! == .Update {
                   CategorySettingViewDeleteButton(openDeleteAlert: $openDeleteAlert, currentCategoryColor: $categoryColor)
                    }
    
                    Spacer()
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                Spacer()
            }
            .padding()
            .navigationTitle(Text("Category setting"))
        }
            .ignoresSafeArea(.keyboard)
        .onAppear {
            setOnAppearVariables()
        }
        .alert(isPresented: $openDeleteAlert) {
            Alert(title: Text("Delete category"), message: Text("Are you sure about this? All expenses with this category will be deleted!"), primaryButton: .default(Text("Delete"), action: {
                
                self.presentationMode.wrappedValue.dismiss()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    CoreDataManager(context: viewContext).expenseCategoryCoreDataManager.delete(category: expenseCategory!)
                }
            }), secondaryButton: .default(Text("Go back")))
        }
        }
    }
    
    private func saveOrUpdateMode(saveOrUpdate: SaveOrUpdateMode) -> SaveOrUpdate {
        if saveOrUpdateMode == .Save {
            return .Save
        } else {
            return.Update
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

