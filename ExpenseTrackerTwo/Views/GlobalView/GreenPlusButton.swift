//
//  GreenPlusButton.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-01.
//

import SwiftUI

struct GreenPlusButton: View {
    
    var buttonHeight: CGFloat = 70
    var buttonWidth: CGFloat = 70
    
    var body: some View {
        ZStack {
            Color.green
                .frame(width: buttonWidth, height: buttonHeight)
                .cornerRadius(buttonWidth/2)
            Image(systemName: "plus")
                .foregroundColor(Color.white)
        }
    }
}

struct GreenPlusButton_Previews: PreviewProvider {
    static var previews: some View {
        GreenPlusButton()
    }
}
