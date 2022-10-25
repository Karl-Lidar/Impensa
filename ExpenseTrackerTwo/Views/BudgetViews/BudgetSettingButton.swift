//
//  BudgetSettingButton.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-24.
//

import SwiftUI

struct BudgetSettingButton: View {
    var body: some View {
        ZStack {
        Color.white
            .frame(width: 40, height: 40, alignment: .center)
            .cornerRadius(20)
        Image(systemName: "gearshape.2.fill")
                .foregroundColor(Color.black.opacity(0.6))
        }
    }
}

struct BudgetSettingButton_Previews: PreviewProvider {
    static var previews: some View {
        BudgetSettingButton()
    }
}
