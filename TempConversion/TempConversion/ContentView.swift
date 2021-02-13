//
//  ContentView.swift
//  WeSplit
//
//  Created by Mary Keefe on 1/4/21.
//

import SwiftUI

struct ContentView: View {
    @State private var tempEntered = ""
    @State private var selectedUnit = 0
    @State private var destinationUnit = 0
    @State private var convertedUnit = ""

    let tempUnits = [ "Celsius","Fahrenheit","Kelvin" ]
    
    var tempInCelsius:Double {
        if tempUnits[selectedUnit].lowercased() == "celsius"{
            return Double(tempEntered) ?? 0
        }
        return 2.0
    
    }
    

    var body: some View {
        NavigationView {
            Form {

                Section {
                    TextField("Temperature", text: $tempEntered)
                        .keyboardType(.decimalPad)
                    
                    
                    Picker("Temperature Units", selection: $selectedUnit) {
                        ForEach(0 ..< tempUnits.count) {
                            Text("\(tempUnits[$0])")
                        }
                    }
                    
                    Picker("Destination Unit", selection: $destinationUnit) {
                        ForEach(0 ..< tempUnits.count) {
                            Text("\(tempUnits[$0])")
                        }
                    }
                }
                Section {
                    Text("temp in Celsius:\(tempInCelsius)")
                }


            }
            .navigationBarTitle("TempConversion")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*
 //
 //  ContentView.swift
 //  WeSplit
 //
 //  Created by Mary Keefe on 1/4/21.
 //

 import SwiftUI

 struct ContentView: View {
     @State private var checkAmount = ""
     @State private var numberOfPeople = 2
     @State private var tipPercentage = 2
     
     let tipPercentages = [10, 15, 20, 25, 0]
     
     var totalPerPerson: Double {
         let peopleCount = Double(numberOfPeople + 2)
         let amountPerPerson = grandTotal / peopleCount
         return amountPerPerson
     }
     
     var grandTotal: Double {
         let tipSelection = Double(tipPercentages[tipPercentage])
         // - checkAmount is actual Double? because can't be sure it cast correctly (could have invalid data entered)
         // so used nil coalescing operator
         let orderAmount = Double(checkAmount) ?? 0
         let tipValue = orderAmount / 100 * tipSelection
         let grandTotal = orderAmount + tipValue
         return grandTotal
     }
     
     
     var body: some View {
         NavigationView {
             Form {
                 Section {
                     TextField("Amount", text: $checkAmount)
                         .keyboardType(.decimalPad)
                     
                     
                     Picker("Number of people", selection: $numberOfPeople) {
                         ForEach(2 ..< 100) {
                             Text("\($0) people")
                         }
                     }
                 }
                 Section(header: Text("How much tip do you want to leave?")) {
                     Picker("Tip percentage", selection: $tipPercentage) {
                         ForEach(0 ..< tipPercentages.count) {
                             Text("\(self.tipPercentages[$0])%")
                         }
                     }
                 }
                 
                 Section(header: Text("Total Amount")) {
                     Text("$\(grandTotal, specifier: "%.2f")")
                 }
                 
                 Section(header: Text("Amount Per Person:")) {
                     Text("$\(totalPerPerson, specifier: "%.2f")")
                 }
             }
             // naviagtion Bar titles are attached at form level -
             // because titles can change w/in different views
             .navigationBarTitle("WeSplit")
         }
     }
 }


 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
         ContentView()
     }
 }






 */





