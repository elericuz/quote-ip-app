//
//  CustomTextFieldStyle.swift
//  MyBudget
//
//  Created by Eric Valera Miller on 23/07/24.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding()
            .background(.white)
            .cornerRadius(8)
            .font(Font.custom("Poppins-Regular", size: Sizes.placeholder))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.secondaryDark, lineWidth: 1)
                    .frame(height: 48)
            )
            .foregroundColor(.primaryDark)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func placeholderForPassword<Content: View>(
            _ placeholder: Content,
            alignment: Alignment = .leading,
            isShowing: Bool
        ) -> some View where Content: View {
            ZStack(alignment: alignment) {
                placeholder.opacity(isShowing ? 1 : 0)
                self
            }
        }
}
