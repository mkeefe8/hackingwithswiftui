//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mary Keefe on 1/9/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var countries =  ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private  var correctAnswer = Int.random(in: 0...2)
    @State private var alertMessage = ""
    @State private var correctFlag = false
    
    
    var body: some View {
        ZStack {
            //Color.blue.edgesIgnoringSafeArea(.all).opacity(0.8)
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).opacity(0.90)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing:30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                              flagTapped(number)
                        }) {
                            FlagView(country: countries[number]).modifier(AnswerModifier(flagTapped: showingScore, userCorrect: correctFlag, correctAnswer: correctAnswer, curFlag:number))
                        }

                        
                    }
                    
                    .alert(isPresented: $showingScore) {
                        Alert(title: Text(scoreTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue")) {
                            askQuestion()
                        })
                    }
                    
                    Text("Current Score: \(score)")
                        .foregroundColor(.white)
                        //.font(.largeTitle)
                        .fontWeight(.black)
                        .padding()
                    Spacer()
                }
            }
            .onAppear(perform: askQuestion)
            
        }
        
    }
    
    
    
    func flagTapped(_ number: Int)  {
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            alertMessage = "Your score is \(score)"
            correctFlag = true
        } else {
            scoreTitle = "Wrong"
            score -= 1
            alertMessage = "Your score is \(score)"
            alertMessage += "\nYou chose the flag of \(countries[number])"
            correctFlag = false
        }
        
        showingScore = true
    }
    
    
    
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}



struct FlagView: View {
    let country: String
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}


struct AnswerModifier: ViewModifier {
    let flagTapped: Bool
    let userCorrect: Bool
    let correctAnswer: Int
    let curFlag: Int
    
    func body(content: Content) -> some View {
        print("\(flagTapped), \(userCorrect),\(correctAnswer),\(curFlag)")
        if !flagTapped {
            print(": NOT FLAG TAPPED")
            return content.rotation3DEffect(.degrees(0), axis: (x: 0, y: 0, z: 0)).opacity(1.0).animation(.default)
            
        }
        if flagTapped {
            if userCorrect  && curFlag == correctAnswer {
                print("condition 1")
                return content.rotation3DEffect(.degrees(360), axis: (x: 0, y: 1, z: 0)).opacity(1.0).animation(.default)
            }
        
            if userCorrect  && curFlag != correctAnswer {
                print("condition 2")
                return content.rotation3DEffect(.degrees(0), axis: (x: 0, y: 1, z: 0)).opacity(0.25).animation(.default)
            }
            
            if !userCorrect && curFlag == correctAnswer{
                print("condition 3")
                return content.rotation3DEffect(.degrees(0), axis: (x: 0, y: 1, z: 0)).opacity(1.0).animation(.default)
            }
            
            if !userCorrect && curFlag != correctAnswer{
                print("condition 4")
                return content.rotation3DEffect(.degrees(0), axis: (x: 0, y: 1, z: 0)).opacity(0.25).animation(.default)
            }
            
        }
        print(": sad default return")
        return content.rotation3DEffect(.degrees(0), axis: (x: 0, y: 0, z: 0)).opacity(1.0).animation(.default)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
