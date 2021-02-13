//
//  ContentView.swift
//  Conditional Modifiers Scrachwork
//
//  Created by Mary Keefe on 1/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var useRedText = false

    var body: some View {
        Button("Hello World") {
            // flip the Boolean between true and false
            self.useRedText.toggle()
        }
        .foregroundColor(useRedText ? .red : .blue)
    }
}

/* NOT ALLOWED: - because 'some View' must return the SAME type of view, no matter
 // waht the conditions are
 var body: some View {
     if self.useRedText {
         return Text("Hello World")
     } else {
         return Text("Hello World")
             .background(Color.red)
     }
 }

 */



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
