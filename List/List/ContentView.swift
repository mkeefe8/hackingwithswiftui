//
//  ContentView.swift
//  List
//
//  Created by Mary Keefe on 1/17/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            Text("Hello World")
            Text("Hello World")
            Text("Hello World")
        }
        
        List {
            ForEach(0..<5) {
                Text("Dynamic row \($0)")
            }
        }
        
        List {
            Text("Static row 1")
            Text("Static row 2")
            
            ForEach(0..<5) {
                Text("Dynamic row \($0)")
            }
            
            Text("Static row 3")
            Text("Static row 4")
        }
        
        List {
            Section(header: Text("Section 1")) {
                Text("Static row 1")
                Text("Static row 2")
            }
            
            Section(header: Text("Section 2")) {
                ForEach(0..<5) {
                    Text("Dynamic row \($0)")
                }
            }
            
            Section(header: Text("Section 3")) {
                Text("Static row 3")
                Text("Static row 4")
            }
        }
        //.listStyle(GroupedListStyle())
        
        let people = ["Finn", "Leia", "Luke"]
        List(people, id: \.self) {
            Text($0)
        }
        
        List {
            ForEach(people, id: \.self) {
                Text($0)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
