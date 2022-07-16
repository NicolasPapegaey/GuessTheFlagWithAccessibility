//
//  ContentView-ViewModel.swift
//  GuessTheFlag
//
//  Created by Nicolas Papegaey on 16/07/2022.
//

import Foundation

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
        
        @Published var correctAnswer = Int.random(in: 0...2)
        
        @Published var showingScore = false
        @Published var showingGameOver = false
        
        @Published var scoreTitle = ""
        @Published var score = 0
        
        @Published var numberOfQuestions = 8
        @Published var selectedFlag = -1

        
        func flagTapped(_ number: Int) {
            if number == correctAnswer {
                scoreTitle = "Correct"
                score += 1
            } else {
                scoreTitle = "Wrong! That's the flag of \(countries[number])"
                score -= 1
            }
            numberOfQuestions -= 1
            if numberOfQuestions == 0 {
                showingGameOver = true
            } else {
                showingScore = true
            }
        }
        
        func askQuestion() {
            selectedFlag = -1
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
        
        func restartGame() {
            askQuestion()
            score = 0
            numberOfQuestions = 8
        }
    }
}
