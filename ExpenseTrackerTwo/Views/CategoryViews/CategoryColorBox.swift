//
//  CategoryColorBox.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-25.
//

import SwiftUI

struct CategoryColorBox: View {
    
    @Binding var categoryColor: Color
    
    var colorsOne = [Color.red, Color.blue, Color.brown]
    var colorsTwo = [Color.yellow, Color.pink, Color.purple]
    var colorsThree = [Color.cyan, Color.indigo, Color.orange, Color.mint]
    
    var colorRealOne = [Color.cyan, Color.blue, Color.indigo]
    var colorRealTwo = [Color.yellow, Color.orange, Color.pink, Color.red]
    var colorRealThree = [Color.purple, Color.mint, Color.brown]
    
   
    
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(25)
            VStack {
                HStack {
                   
                    ForEach(colorRealOne, id: \.self) { color in
                        CategorySettingColorButton(pickedColor: $categoryColor, buttonColor: color)
                    }
                   
                }
                
                HStack {
                    ForEach(colorRealTwo, id: \.self) { color in
                        CategorySettingColorButton(pickedColor: $categoryColor, buttonColor: color)
                    }
                   
                }
                
                HStack {
                 
                    ForEach(colorRealThree, id: \.self) { color in
                        CategorySettingColorButton(pickedColor: $categoryColor, buttonColor: color)
                    }
                   
                }
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        }
        .customShadow()
        .fixedSize()
    }
}

struct CategoryColorBox_Previews: PreviewProvider {
    static var previews: some View {
        CategoryColorBox(categoryColor: .constant(Color.green))
    }
}
