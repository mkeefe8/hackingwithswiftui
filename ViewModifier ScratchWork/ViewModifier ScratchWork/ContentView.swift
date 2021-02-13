//
//  ContentView.swift
//  ViewModifier ScratchWork
//
//  Created by Mary Keefe on 1/10/21.
//
 

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.green
                .frame(width: 300, height: 200)
            Text("Hello World")
                .titleStyle()
        }
        .watermarked(with: "Hacking with Swift")

    }
    
}

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.orange)
            .background(Color.blue)
            .clipShape(Capsule())

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

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
