//
//  AddExpenseListTextView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-19.
//

import SwiftUI

struct AddExpenseListTextView: View {
    
    @Binding var selectedNameFromList: String
    @Binding var openListView: Bool
    @Binding var activateBlurView: Bool

    var body: some View {
        
        VStack {
        Text(selectedNameFromList)
            .multilineTextAlignment(.center)
            .foregroundColor(Color.black.opacity(opactityFor(text: selectedNameFromList)))
            .font(Font.system(size: 30))
            .padding(EdgeInsets(top: 10, leading: 10, bottom: -3, trailing: 10))
            .onTapGesture {
                withAnimation {
                    openListView.toggle()
                    activateBlurView.toggle()
                }
            }
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 30)
                .background(Color.black.opacity(0.2))
        }
    }
    
    func opactityFor(text: String) -> Double {
        if text == "Category" || text == "Budget" {
            return 0.2
        } else {
            return 0.9
        }
    }
}

struct AddExpenseListTextView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseListTextView(selectedNameFromList: .constant("My Cat"), openListView: .constant(false), activateBlurView: .constant(false))
    }
}
