//
//  SaveButtonView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-01.
//

import SwiftUI

struct SaveButtonView: View {
    
    var buttonHeight: CGFloat = 40
    var buttonWidth: CGFloat = 125
    var color: Color
    
    var body: some View {
        ZStack {
            Color.white
                .frame(width: buttonWidth, height: buttonHeight, alignment: .center)
                .cornerRadius(buttonHeight/2)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 4)
            Text("Save")
                .foregroundColor(color)
                .frame(alignment: .center)
        }
    }
}

struct SaveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SaveButtonView(color: Color.green)
    }
}
