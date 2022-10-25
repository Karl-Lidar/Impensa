//
//  CategorySettingViewDeleteButton.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-24.
//

import SwiftUI

struct CategorySettingViewDeleteButton: View {
    
    @Binding var openDeleteAlert: Bool
    @Binding var currentCategoryColor: Color
    
    var body: some View {
        Button {
         
                openDeleteAlert.toggle()
            
        } label: {
            ZStack {
            Color.white
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
                Image(systemName: "trash.fill")
                    .foregroundColor(currentCategoryColor)
            }
        }
    }
}

struct CategorySettingViewDeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        CategorySettingViewDeleteButton(openDeleteAlert: .constant(false), currentCategoryColor: .constant(Color.green))
    }
}
