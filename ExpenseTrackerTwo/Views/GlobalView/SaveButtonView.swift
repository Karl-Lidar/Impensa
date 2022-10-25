//
//  SaveButtonView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-01.
//

import SwiftUI

enum SaveOrUpdate {
    case Save
    case Update
}

struct SaveButtonView: View {
    
    var buttonHeight: CGFloat = 40
    var buttonWidth: CGFloat = 125
    var color: Color
    var saveOrUpdate: SaveOrUpdate
    
    var body: some View {
        ZStack {
            Color.white
                .frame(width: buttonWidth, height: buttonHeight, alignment: .center)
                .cornerRadius(buttonHeight/2)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 4)
            Text(buttonText())
                .foregroundColor(color)
                .frame(alignment: .center)
        }
    }
    
    private func buttonText() -> String {
        if saveOrUpdate == .Save {
            return "Save"
        } else {
            return "Update"
        }
    }
}

struct SaveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SaveButtonView(color: Color.green, saveOrUpdate: .Save)
    }
}
