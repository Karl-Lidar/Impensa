//
//  ExpenseSettingBudgetView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-03.
//

import SwiftUI
import Liquid

struct ExpenseSettingBudgetView: View {
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var selectedBudgetName: String
    
    var body: some View {
       
        GeometryReader { geometry in
            ZStack {
                
                BackgroundSplashView(multiplier: 1.65, color: Color.green)
                   
                  
            VStack {
                Spacer()
            PickBudgetTableView(selectedBudgetName: $selectedBudgetName)
                    .frame(width: geometry.size.width, height: geometry.size.height/2)
            
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    SaveButtonView(color: Color.green, saveOrUpdate: .Save)
                }

                Spacer()
            }
            }
        }
        .padding()
        .navigationTitle(Text("Change budget"))
      
    }
}

