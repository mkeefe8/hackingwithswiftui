//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mary Keefe on 1/9/21.
//

import SwiftUI

struct ContentView2: View {
    
    @State private var showingAlert = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var flagChosen = -1
    
    
    var body: some View {
        ZStack{
            
           // Color.blue.edgesIgnoringSafeArea(.all)
            LinearGradient(gradient: Gradient(colors: [.blue, .purple, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30 ){
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                //.foregroundColor(.white)
                
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        flagTapped(number)
                    }) {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
            
                Text("Current Score: \(score)")
                
                Spacer()
            }
            .foregroundColor(.white)
        }
       // .alert(isPresented: $showingScore) {
        //    Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
        //        self.askQuestion()
        //    })
         .alert(isPresented: $showingAlert) {
            Alert(title: Text(scoreTitle), message: Text(getAlertMessage(score: score, flagChosen: flagChosen)), dismissButton: .default(Text("Continue")) {
                 self.askQuestion()
             })
        }
    }
    
    func flagTapped(_ number: Int) {
        flagChosen = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            score -= 1
        }
        showingAlert = true
        
    }
    
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func getAlertMessage(score: Int, flagChosen number: Int)  -> String {
        var message = ""
        if scoreTitle == "Wrong" {
           message += "\nYou chose the flag of \(countries[number])"
        }
         message += "\n\nYour score: \(score)"

        return  message
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
