//
//  AddBudgetGoal.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-30.
//

import SwiftUI


struct AddBudgetGoal: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ExpenseCategory.name, ascending: true)],
        animation: .default)
    
    private var categories: FetchedResults<ExpenseCategory>
    
    @Binding var budgetGoals: [TempBudgetGoals]
    @State var openDeleteAlert = false
    @State var amount: String = ""
    @State var selectedCategoryName = ""
    var amountTemp = ""
    var selectedCategoryNameTemp = ""
    
    var mode: SaveOrUpdate
    
    @State var openListView = false
    @State var blurBackground = false
    @State var openPickCategoryView = false
    @State var blurView = false
    @Binding var backgroundSplashColor: Color
    
    var idForBugdetGoal: UUID?
    
    init(budgetGoals: Binding<[TempBudgetGoals]>, mode: SaveOrUpdate, amount: Double, expenseCategory: ExpenseCategory, backgroundSplashColor: Binding<Color>, idForBugdetGoal: UUID) {
        self._budgetGoals = budgetGoals
        self.mode = mode
        self.amountTemp = String(amount)
        self.selectedCategoryNameTemp = expenseCategory.name!
        self._backgroundSplashColor = backgroundSplashColor
        self.idForBugdetGoal = idForBugdetGoal
    }
    
    init(budgetGoals: Binding<[TempBudgetGoals]>, mode: SaveOrUpdate, backgroundSplashColor: Binding<Color>) {
        self._budgetGoals = budgetGoals
        self.mode = mode
        self._backgroundSplashColor = backgroundSplashColor
    }
    
    let slideInSlideOut = AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .scale(scale: 0.1)).combined(with: .opacity)
    

    
    //Fortsätt här imorgon
    //1. Skapa olika inits och samma koncept som när man laddar upp expenses som redan finns och kan redigera dem, samma sak här fast med budgets
    //2. Gör så att man kan redigera och ta bort den budget.
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                BackgroundSplashView(multiplier: 1.2, color: backgroundSplashColor)
                 
                VStack {
                    Spacer()
                    TextFieldView(textInput: $amount, holderText: "Amount", textFieldDividerSize: .Wide)
                  //  TextField("Hello", text: $amount)
                    
                    /*
                    ExpenseCategoryListView(selectedCategoryName: $selectedCategoryName)
                        .frame(height: geometry.size.height/2)
                     */
                    AddExpenseListTextView(selectedNameFromList: $selectedCategoryName, openListView: $openPickCategoryView, activateBlurView: $blurBackground)
                        .frame(width: geometry.size.width/1.5)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                        .onAppear {
                            if mode == .Save {
                            selectedCategoryName = "Category"
                            }
                        }
                  //  TextFieldView(textInput: $selectedCategoryName, holderText: "Category", textFieldDividerSize: .Wide)
                    
                    HStack {
                    Button {
                        if mode == .Save {
                    saveBudgetGoal()
                        } else {
                            updateBudgetGoal()
                        }
                    } label: {
                        SaveButtonView(color: backgroundSplashColor, saveOrUpdate: mode)
                    }
                        if mode == .Update {
                        Button {
                            openDeleteAlert.toggle()
                        } label: {
                            ZStack {
                                Color.white
                                    .frame(width: 40, height: 40, alignment: .center)
                                    .cornerRadius(20)
                                Image(systemName: "trash.fill")
                                    .foregroundColor(backgroundSplashColor)
                            }
                        }
                        .customShadow()
                        }
                       
                    }
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                }
                
                .frame(alignment: .center)
                
                //PICK CATEGORY VIEW
                if openPickCategoryView == true {
                    AddExpenseCategoryPopupView(selectedCategoryName: $selectedCategoryName, showCategories: $openPickCategoryView, blurView: $blurView, currentCategoryColor: $backgroundSplashColor)
                        .customShadow()
                        .transition(slideInSlideOut)
                }
            }
            .alert(isPresented: $openDeleteAlert) {
                Alert(title: Text("Delete goal"), message: Text("Are you sure about this? The budget goal will be delete from the budget"), primaryButton: .default(Text("Delete"), action: {
                    
                    self.presentationMode.wrappedValue.dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        for element in 0..<budgetGoals.count {
                            if budgetGoals[element].id == idForBugdetGoal {
                                budgetGoals.remove(at: element)
                                break
                            }
                        }
                    }
                }), secondaryButton: .default(Text("Go back")))
            }
            .navigationTitle(Text("New goal"))
        }
        .onAppear {
            if mode == .Update {
            amount = amountTemp
                selectedCategoryName = selectedCategoryNameTemp
            }
        }
    }
    
    private func saveBudgetGoal() {
        //TODO: Fix check that the string actually is a possible double value
       
        //TODO: Fix so that we do not have to loop through all of the categories
        for category in categories {
            if category.name! == selectedCategoryName {
                budgetGoals.append(TempBudgetGoals(amount: Double(amount) ?? 0, category: category, id: UUID()))
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    private func updateBudgetGoal() {
        for category in categories {
            if category.name! == selectedCategoryName {
               
                for element in 0..<budgetGoals.count {
                    if budgetGoals[element].id == idForBugdetGoal! {
                        budgetGoals[element].amount = Double(amount)!
                        budgetGoals[element].category = category
                    }
                }
            }
        }
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddBudgetGoal_Previews: PreviewProvider {
    
    static var previews: some View {
        AddBudgetGoal(budgetGoals: .constant([]), mode: .Save, backgroundSplashColor: .constant(Color.green))
    }
}
