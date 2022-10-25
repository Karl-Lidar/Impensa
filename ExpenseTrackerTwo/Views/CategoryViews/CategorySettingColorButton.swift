//
//  CategorySettingColorButton.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-21.
//

import SwiftUI

struct CategorySettingColorButton: View {
    
    @Binding var pickedColor: Color
    var buttonColor: Color
    
    var body: some View {
        withAnimation {
            Button {
                withAnimation {
                    pickedColor = buttonColor
                }
                
            } label: {
                            buttonColor
                                .frame(width: 50, height: 50)
                                .cornerRadius(25)
                                
            }
        }
    }
}

struct CategorySettingColorButton_Previews: PreviewProvider {
    static var previews: some View {
        CategorySettingColorButton(pickedColor: .constant(Color.green), buttonColor: Color.green)
    }
}
