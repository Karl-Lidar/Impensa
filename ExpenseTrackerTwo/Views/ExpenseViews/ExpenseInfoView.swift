//
//  ExpenseInfoView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-17.
//

import SwiftUI

struct ExpenseInfoView: View {
    
    var expense: Expense
    
    var body: some View {
        
       
            HStack {
                Text(expense.name!)
                    .foregroundColor(Color.black)
                Spacer()
                ZStack {
                    StringColorConverter().colorFor(colorName: expense.expenseCategory!.colorName!)
                        .opacity(0.8)
                        .frame(height: 30)
                        .cornerRadius(30/2)
                Text("\(String(expense.amount))")
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                      
               
                }
                .fixedSize()
            }
            
           /*
            HStack {
                        StringColorConverter().colorFor(colorName: expense.expenseCategory!.colorName!)
                            .frame(width: 20, height: 20)
                            .cornerRadius(20/2)
               
                        Text(expense.name!)
                            .padding(EdgeInsets(top:0 , leading: 0, bottom: 0, trailing: 10))
                
                        Spacer()
                    
             
                Text("\(String(expense.amount)) sek")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
            
            }
            */
        }
}

struct ExpenseInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseInfoView(expense: PreviewManager(viewContext: PersistenceController.preview.container.viewContext).getSingleExpense()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

/*
HStack {
    Spacer()
    ZStack {
        Color(UIColor.systemGray5)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
        ZStack {
            HStack {
                VStack {
                    Spacer()
                    ZStack {
                        Color.green
                            .frame(height: 40)
                            .cornerRadius(15, corners: [.topRight, .bottomLeft])
                        Text(expense.expenseCategory!.name!)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    }
                    .fixedSize()
                }
                VStack {
                    Spacer()
                    
                    ZStack {
                        Color(UIColor.systemGray3)
                            .frame(height: 25)
                            .cornerRadius(15, corners: [.topRight])
                        Text(DateFormatter.displayDate.string(from: expense.date ?? Date()))
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    }
                    .fixedSize()
                    
                }
                .padding(EdgeInsets(top: 0, leading: -8, bottom: 0, trailing: 0))
                Spacer()
            }
            HStack {
                VStack {
                    HStack {
                        VStack {
                            ZStack {
                                Color(UIColor.systemGray3)
                                    .frame(height: 45)
                                    .cornerRadius(20, corners: [.bottomRight, .topLeft])
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                                
                                Text(expense.wrappedFirstName)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                    .font(.system(size: 20))
                            }.fixedSize()
                        }
                    }
                    Spacer()
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("\(expense.amount, specifier: "%.0f") sek")
                            .font(.system(size: 20))
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                    Spacer()
                }
            }
        }
    }.frame(width: geometry.size.width/1.2, height: 100)
    Spacer()
}
 */
