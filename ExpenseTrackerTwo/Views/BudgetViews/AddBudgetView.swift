//
//  AddBudgetView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-30.
//

import SwiftUI

struct TempBudgetGoals: Hashable {
    var amount: Double
    var category: ExpenseCategory
    var id: UUID
}

struct AddBudgetView: View {
    @Environment(\.managedObjectContext) private var viewContext
   @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var openDeleteAlert = false
    @State var budgetName = ""
    @State var budgetGoals: [TempBudgetGoals] = []
    @State var openPickCategoryView = false
    @State var blurView = false
    @State var selectedCategoryName = ""
    @State var backgroundSplashColor = Color.green
    var alreadyExistingBudgetTable: BudgetTable?
    
    var mode: SaveOrUpdate
    
    let slideInSlideOut = AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .scale(scale: 0.1)).combined(with: .opacity)
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
           
                BackgroundSplashView(multiplier: 1.4, color: Color.green)
                
                VStack {
                    Spacer()
                    TextFieldView(textInput: $budgetName, holderText: "Budget name", textFieldDividerSize: .Medium)
                  
                    
                    BudgetGoalsListView(budgetGoals: $budgetGoals, backgroundSplashColor: $backgroundSplashColor)
                        .frame(width: geometry.size.width/1.2, height: geometry.size.height/2.4)
                        .customShadow()
                    
                    HStack {
                    Button {
                        if mode == .Save {
                       saveBudget()
                        } else {
                            updateBudget()
                        }
                    } label: {
                        SaveButtonView(color: Color.green, saveOrUpdate: mode)
                    }
                        if mode == .Update {
                            Button {
                                openDeleteAlert.toggle()
                            } label: {
                                ZStack {
                                Color.white
                                    .frame(width: 40, height: 40, alignment: .center)
                                    .cornerRadius(20)
                                    .customShadow()
                                Image(systemName: "trash.fill")
                                    .foregroundColor(Color.green)
                                }
                            }

                        }
                    }
                    Spacer()
                }
                .frame(alignment: .center)
        }
            .alert(isPresented: $openDeleteAlert) {
                Alert(title: Text("Delete budget"), message: Text("Are you sure about this? The budget and all expenses will be deleted"), primaryButton: .default(Text("Delete"), action: {
                    
                    self.presentationMode.wrappedValue.dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        CoreDataManager(context: viewContext).coreDataBudgetManager.deleteBudgetTable(budgetTable: alreadyExistingBudgetTable!)
                    }
                }), secondaryButton: .default(Text("Go back")))
            }
            .navigationTitle(Text("New budget"))
        }
    }
    
    private func saveBudget() {
        let coreDataManager = CoreDataManager(context: viewContext)
        coreDataManager.coreDataBudgetManager.createbudgetTable(budgetName: budgetName, budgetGoals: budgetGoals)
       self.presentationMode.wrappedValue.dismiss()
    }
    
    private func updateBudget() {
        let coreDataManager = CoreDataManager(context: viewContext)
        coreDataManager.coreDataBudgetManager.updateBudgetTable(budgetName: budgetName, budgetGoals: budgetGoals, currentBudget: alreadyExistingBudgetTable!)
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func deleteBudget() {
        
    }
}

struct AddBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        AddBudgetView(mode: .Save)
    }
}
