//
//  TextFieldView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-01.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var textInput: String
    var holderText: String
    
    var body: some View {
        TextField(holderText, text: $textInput)
            .multilineTextAlignment(.center)
    .font(Font.system(size: 30))
    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
        Divider()
            .frame(width: 200, height: 1)
         .padding(.horizontal, 30)
         .background(Color.black.opacity(0.2))
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(textInput: .constant(""), holderText: "Default")
    }
}
