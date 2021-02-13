//
//  ContentView.swift
//  ShowingAndHidingViewsWithTransitions
//
//  Created by Mary Keefe on 1/19/21.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                self.isShowingRed.toggle()
                withAnimation {
                    self.isShowingRed.toggle()
                }
            }
            if isShowingRed {
            Rectangle()
                .fill(Color.red)
                .frame(width: 200, height: 200)
                .transition(.scale)
                // asymmetric lets one transition happen when show when view is appearing
                // and another transiiton happen when it's disappearing
                // .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
