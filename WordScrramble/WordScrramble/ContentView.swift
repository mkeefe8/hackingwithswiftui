//
//  ContentView.swift
//  WordScrramble
//
//  Created by Mary Keefe on 1/17/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)

    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                
                Text("Score: \(score)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .border(Color.accentColor)
                   .frame(height: 60)
                   .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                   .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.green))
                    .padding()

                
                
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(leading:
                Button("New Game") {
                  startGame()
                })
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        guard answer.count > 0 else {
            return
        }
        
        guard longEnough(word: answer) else {
            wordError(title: "Too short", message: "Words must be at least three letters!")
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Enter unique words!")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "Bzzz!!!! Word is not possible!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Not Real Words", message: "Word is not in dictionary!")
            return
        }

        updateScore(word: answer)
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func longEnough(word:String) -> Bool {
        word.count >= 3
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
    
    // is the word in UITectChecker dictionary?
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func updateScore(word: String){
        print(word, word.count)
        score += word.count - 2
    }
    
    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")

                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                
                score = 0

                // If we are here everything has worked, so we can exit
                return
            }
        }

        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
