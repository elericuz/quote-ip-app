//
//  CustomButtonStyle.swift
//  MyBudget
//
//  Created by Eric Valera Miller on 23/07/24.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Poppins-SemiBold", size: Sizes.primaryButtonText))
            .foregroundColor(.white)
            .frame(height: 52)
            .frame(maxWidth: .infinity, maxHeight: 52)
            .background(.secondaryDark)
            .cornerRadius(8)
    }
}

extension View {
    func primaryButtonStyle() -> some View {
        self.modifier(PrimaryButtonStyle())
    }
}
