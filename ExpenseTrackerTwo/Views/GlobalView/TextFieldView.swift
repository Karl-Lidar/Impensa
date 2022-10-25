//
//  TextFieldView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-01.
//

import SwiftUI

enum TextFieldDividerSize {
    case Wide
    case Medium
    case Small
}

struct TextFieldView: View {
    @Binding var textInput: String
    var holderText: String
    var textFieldDividerSize: TextFieldDividerSize
    @State var text = ""
    
    var body: some View {
        TextField(holderText, text: $textInput)
            .multilineTextAlignment(.center)
    .font(Font.system(size: 30))
    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
        Divider()
            .frame(width: getDividerWith(textFieldDividerSize: textFieldDividerSize), height: 1)
         .padding(.horizontal, 30)
         .background(Color.black.opacity(0.2))
    }
    
    private func getDividerWith(textFieldDividerSize: TextFieldDividerSize) -> CGFloat {
        
        if textFieldDividerSize == .Wide {
            return 200
        } else if textFieldDividerSize == .Medium {
            return 175
        } else {
            return 150
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(textInput: .constant(""), holderText: "Default", textFieldDividerSize: .Wide)
    }
}
