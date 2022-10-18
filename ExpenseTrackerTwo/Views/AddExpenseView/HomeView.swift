//
//  HomeView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
              
                ZStack {
                    BackgroundSplashView(multiplier: 0.8, color: Color.green)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        .scaleEffect()
                        
                   
                NavigationLink {
                    AddExpenseView()
                } label: {
                    ZStack {
                    Color.white
                        .frame(width: 100, height: 100)
                        .cornerRadius(100/2)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    Image(systemName: "plus")
                            .foregroundColor(Color.green.opacity(0.8))
                    }
                }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
