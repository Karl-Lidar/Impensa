//
//  TestView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-24.
//

import SwiftUI

struct TestView: View {
    @State var text = ""
    var body: some View {
       
        TextField("Hello", text: $text)
       

    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
