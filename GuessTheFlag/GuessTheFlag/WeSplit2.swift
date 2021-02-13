//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mary Keefe on 1/9/21.
//

import SwiftUI

struct WeSplit2: View {
    
    @State private var checkAmount = ""
    @State private var peopleRowIndex = 2
    @State private var tipIndex = 2

    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    
    var totalPerPerson: Double {
        let peopleCount = Double(peopleRowIndex + 2)
        print(peopleRowIndex)
        let tipSelection = Double(tipPercentages[tipIndex])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
   
    }
    
    

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter Check Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                
                
                Section {
                    
                    Picker("Number of people", selection: $peopleRowIndex) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
            }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipIndex) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
                
                Section {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
        }
        .navigationBarTitle("WeSplit")
        
        }
    }
}


struct WeSplit_Previews: PreviewProvider {
    static var previews: some View {
        WeSplit2()
    }
}
 
