//
//  ExpenseSettingCategoryView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-03.
//

import SwiftUI

struct ExpenseSettingCategoryView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var selectedCatoryName: String
    @State var currentPage = 1
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
            PickExpenseCategoryView(selectedCatoryName: $selectedCatoryName, currentAddExpensePage: $currentPage, withSaveButton: false)
                .frame(height: geometry.size.height/2)
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    SaveButtonView(color: Color.green, saveOrUpdate: .Save)
                }

                Spacer()
            }
        }
        .padding()
        .navigationTitle(Text("Change category"))
       
    }
}

