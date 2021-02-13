//
//  ContentView.swift
//  AnimatingBindings
//
//  Created by Mary Keefe on 1/18/21.
//

import SwiftUI
struct ContentView: View {
    @State private var animationAmount: CGFloat = 1

    var body: some View {
        VStack {
   
           //Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
          
            Stepper("Scale amount", value: $animationAmount.animation(
                Animation.easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10)
 

            Spacer()

            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}
 
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
