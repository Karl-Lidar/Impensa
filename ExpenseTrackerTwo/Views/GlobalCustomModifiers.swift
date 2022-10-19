//
//  CustomModifiers.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-10-19.
//

import SwiftUI

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct CustomShadow: ViewModifier {

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
        }
    }
}

extension View {
    func customShadow() -> some View {
        modifier(CustomShadow())
    }
}
