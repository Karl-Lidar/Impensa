//
//  TesterView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-24.
//

import SwiftUI

struct TesterView: View {
    var body: some View {
        NavigationLink(destination: TestView()) {
           ListViewLinkButton(buttonName: "New goal", buttonHeight: 40)
                .navigationTitle(Text("New budget"))
        }
    }
}

struct TesterView_Previews: PreviewProvider {
    static var previews: some View {
        TesterView()
    }
}
