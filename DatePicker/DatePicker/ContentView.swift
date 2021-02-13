//
//  ContentView.swift
//  DatePicker
//
//  Created by Mary Keefe on 1/11/21.
//

import SwiftUI

/*
let now = Date()
// create a second Date instance set to one day in seconds from now
let tomorrow = Date().addingTimeInterval(86400)
// create a range from those two
let range = now ... tomorrow
 */

struct ContentView: View {
    @State private var wakeUp = Date()
    

    
    // **** Can use either of the two ways below
    
    
    var body: some View {
       // DatePicker("Please enter a date", selection: $wakeUp)
      //  DatePicker("", selection: $wakeUp)
        Form {
           // DatePicker("Please enter a date", selection: $wakeUp)
           // DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
            // range below is from now to .... whenever in the future
           // DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
           // DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute )
            DatePicker("Please enter a date", selection: $wakeUp, in: Date()... , displayedComponents: .hourAndMinute)
                .labelsHidden()

        }
    }
 
    /*
    var body: some View {
        DatePicker("Please enter a date", selection: $wakeUp)
            .labelsHidden()
    }
 */
    
/* Other date code
 var components = DateComponents()
 components.hour = 8
 components.minute = 0
     // date(from: ) returns an optional, so use nil coalescing
let date = Calendar.current.date(from: components) ?? Date()

 */
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
