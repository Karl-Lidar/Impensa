//
//  CategoryColorBox.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-25.
//

import SwiftUI

struct CategoryColorBox: View {
    
    @Binding var categoryColor: Color
    var colorsOne = [Color.red, Color.green, Color.blue, Color.brown]
    var colorsTwo = [Color.yellow, Color.pink, Color.purple, Color.gray]
    var colorsThree = [Color.cyan, Color.indigo, Color.orange, Color.mint]
   
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray5)
                .cornerRadius(25)
            VStack {
                HStack {
                    ForEach(colorsOne, id: \.self) { color in
                        CategorySettingColorButton(pickedColor: $categoryColor, buttonColor: color)
                    }
                }
                
                HStack {
                    ForEach(colorsTwo, id: \.self) { color in
                        CategorySettingColorButton(pickedColor: $categoryColor, buttonColor: color)
                    }
                }
                
                HStack {
                    ForEach(colorsThree, id: \.self) { color in
                        CategorySettingColorButton(pickedColor: $categoryColor, buttonColor: color)
                    }
                }
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        }
        .fixedSize()
    }
}

struct CategoryColorBox_Previews: PreviewProvider {
    static var previews: some View {
        CategoryColorBox(categoryColor: .constant(Color.green))
    }
}
