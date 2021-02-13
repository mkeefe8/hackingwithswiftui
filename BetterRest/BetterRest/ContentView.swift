//
//  ContentView.swift
//  BetterRest
//
//  Created by Mary Keefe on 1/11/21.
//

import SwiftUI
import CoreML



struct ContentView: View {
    
   static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
   // @State private var wakeUp = Date()
    @State private var wakeUp = defaultWakeTime

    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 30){
                Text("When do you want to wake up?").font(.headline)
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                
                Divider()
                Text("Desired amoount of sleep").font(.headline)
                Stepper("", value: $sleepAmount, in: 4...12, step: 0.25)
                    .labelsHidden()
                Text("\(sleepAmount, specifier: "%g") hours")
                
                
                Divider()
                Text("Daily coffee intake")
                    .font(.headline)
                Stepper("",value: $coffeeAmount, in: 1...20)
                    .labelsHidden()
                if coffeeAmount == 1 {
                    Text("1 cup")
                } else {
                    Text("\(coffeeAmount) cups")
                }
            }
            .navigationBarTitle("BetterRest")
            .navigationBarItems(trailing:
                                    Button(action: calculateBedtime) {
                                        Text("Calculate")
                                    })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func calculateBedtime() {

        do {
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let model: SleepCalculator = try SleepCalculator(configuration: MLModelConfiguration())
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
         
            let formatter = DateFormatter()
            formatter.timeStyle = .short

            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is…"
      
            showingAlert = true
        } catch {
            print(error)
            // something went wrong!
        }

        
    }
}
        
        
        
        
        
        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
