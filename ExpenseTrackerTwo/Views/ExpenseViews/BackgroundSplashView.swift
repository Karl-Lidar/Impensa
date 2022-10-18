//
//  BackgroundSplashView.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-03.
//

import SwiftUI
import Liquid

struct BackgroundSplashView: View {
    
    var multiplier: CGFloat
    var offsetToSmall: CGFloat = 0.15
    var offsetProcent: CGFloat = 0.14
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
            Liquid()
                .foregroundColor(color)
                .opacity(0.15)
                .frame(width: geometry.size.width*(multiplier), height: geometry.size.width*(multiplier))
            Liquid()
                .foregroundColor(color)
                .opacity(0.3)
                .frame(width: geometry.size.width*(multiplier-(multiplier*offsetProcent)), height: geometry.size.width*(multiplier-(multiplier*offsetProcent)))
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .position(x: geometry.size.width/2, y: geometry.size.height/2)
            .clipShape(Rectangle())
            .padding(EdgeInsets(top: 0, leading: -15, bottom: 0, trailing: -15))
        }
    }
}

struct BackgroundSplashView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundSplashView(multiplier: 1.65, color: Color.blue)
    }
}
