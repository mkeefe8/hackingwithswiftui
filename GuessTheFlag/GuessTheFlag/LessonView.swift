//
//  SwiftUIView.swift
//  GuessTheFlag
//
//  Created by Mary Keefe on 1/23/21.
//

import SwiftUI

struct LessonView: View {
    var body: some View {
        List(0..<100) { i in
            Text("Row \(i)")
        }
        .listStyle(InsetGroupedListStyle())

    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct Title2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
            .padding()
            //.background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(Capsule().stroke())
    }
}

struct Gradients:View {
    var body: some View {
        ZStack {
            //Color.green.edgesIgnoringSafeArea(.all)
            // LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
            // AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
            Color.white.frame(width: 200, height: 100)
            Text("Your content")
        }
    }
}

extension View {
    func titleStyle2() -> some View {
        self.modifier(Title2())
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LessonView()
        // Gradients()
    }
}
