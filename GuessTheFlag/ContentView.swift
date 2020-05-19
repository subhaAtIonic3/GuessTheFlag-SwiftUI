//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Subhrajyoti Chakraborty on 16/05/20.
//  Copyright © 2020 Subhrajyoti Chakraborty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var currentScore = 0
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct ! That’s the flag of \(countries[number])"
        } else {
            scoreTitle = "Wrong ! That’s the flag of \(countries[number])"
        }
        showingScore = true
        calculateScore(number)
    }
    func calculateScore(_ number: Int) {
        if number == correctAnswer {
            currentScore += 1
        }
    }
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                Text("Tap the flag of")
                    .foregroundColor(.white)
                    .font(.headline)
                Text(countries[correctAnswer])
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                VStack(spacing: 20) {
                    ForEach(0..<3){ number in
                        FlagView(number: number, countries: self.countries) {
                            self.flagTapped(number)
                        }
                        .alert(isPresented: self.$showingScore) {
                            Alert(title: Text(self.scoreTitle), message: Text("Your score is \(self.currentScore)"), dismissButton: .default(Text("Continue")) {
                                    self.askQuestion()
                                })
                        }
                    }
                    Text("Current score is \(currentScore)")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Spacer()
                }
            }
        }
    }
}

struct FlagView: View {
    var number: Int
    var countries: [String]
    
    var onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Image(self.countries[number])
                .renderingMode(.original)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                .shadow(color: .black, radius: 2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
