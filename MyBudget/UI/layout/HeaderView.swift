//
//  HeaderView.swift
//  MyBudget
//
//  Created by Eric Valera Miller on 23/07/24.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(.backgroundLight.opacity(0.4))
                .frame(width: UIScreen.main.bounds.width*2, height: 500)
                .position(x: UIScreen.main.bounds.width-20, y: -50)
            Circle()
                .fill(.neutralLight.opacity(0.15))
                .frame(width: UIScreen.main.bounds.width*2, height: 500)
                .position(x: UIScreen.main.bounds.width/16, y: 50)
            Circle()
                .fill(Color.secondaryDark.opacity(0.65))
                .frame(width: UIScreen.main.bounds.width, height: 220)
                .position(x: UIScreen.main.bounds.width, y: 0)
                .shadow(color: .secondaryDark, radius: 40, x: 0, y: 4)
        }
        .frame(height: 300)
        .clipped()
        VStack(alignment: .center) {
            BeanShape()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [.secondaryDark.opacity(0.5), .neutralLight.opacity(0.4)]),
                        center: .center,
                        startRadius: 300,
                        endRadius: 30
                    )
                )
                .frame(width: 300, height: UIScreen.main.bounds.height/2)
                .blur(radius: 40)
                .opacity(0.5)
            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .center)
    }
}

struct BeanShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width * 0.5, y: 0))
        path.addCurve(to: CGPoint(x: 0, y: height * 0.7),
                      control1: CGPoint(x: width * 0.1, y: height * 0.1),
                      control2: CGPoint(x: 0, y: height * 0.3))
        path.addCurve(to: CGPoint(x: width * 0.5, y: height),
                      control1: CGPoint(x: 0, y: height),
                      control2: CGPoint(x: width * 0.4, y: height))
        path.addCurve(to: CGPoint(x: width, y: height * 0.3),
                      control1: CGPoint(x: width * 0.6, y: height),
                      control2: CGPoint(x: width, y: height * 0.7))
        path.addCurve(to: CGPoint(x: width * 0.5, y: 0),
                      control1: CGPoint(x: width, y: height * 0.1),
                      control2: CGPoint(x: width * 0.9, y: 0.1 * height))
        
        path.closeSubpath()
        
        return path
    }
}

//#Preview {
//    NavigationStack {
//        ContentView()
//    }
//    .colorScheme(.light)
//}

#Preview {
    NavigationStack {
        VStack {
            HeaderView()
            Spacer()
        }
        .ignoresSafeArea(.all)
    }
    .colorScheme(.light)
}
