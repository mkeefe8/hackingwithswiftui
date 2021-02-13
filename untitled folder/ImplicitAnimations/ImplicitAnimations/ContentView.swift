//
//  ContentView.swift
//  test
//
//  Created by Mary Keefe on 1/18/21.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1.0

    var body: some View {
  
        Button("Tap Me") {
           // self.animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeOut(duration: 1)
                        .repeatForever(autoreverses: false)
                )
        )
        .onAppear {
            self.animationAmount = 2
        }
        //.scaleEffect(animationAmount)
       // .blur(radius: (animationAmount - 1) * 3)
       // .animation(    Animation.easeInOut(duration: 1)
                        //.repeatCount(3, autoreverses: true))
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
