//
//  Extensions.swift
//  The 24 Game
//
//  Created by  on 4/6/22.
//

import SwiftUI

extension View {
    public func border<S>(
        _ content: S,
        width: CGFloat = 1,
        cornerRadius: CGFloat
    ) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
            .overlay(
                roundedRect.strokeBorder(content, lineWidth: width)
            )
    }

    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
