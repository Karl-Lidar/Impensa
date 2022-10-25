//
//  TextViewTwo.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-24.
//

import SwiftUI

struct TextViewTwo: View {
    var body: some View {
        NavigationLink(destination: TestView()) {
           ListViewLinkButton(buttonName: "New goal", buttonHeight: 40)
        }
    }
}

struct TextViewTwo_Previews: PreviewProvider {
    static var previews: some View {
        TextViewTwo()
    }
}
