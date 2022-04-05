//
//  ContentView.swift
//  FlagGuess
//
//  Created by Adam Nowland on 4/1/22.
//

import SwiftUI

struct ButtonFlag: View {
    var specificCountry: String
    
    var body: some View {
        Image(specificCountry)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .font(.title.weight(.heavy))
            .foregroundColor(.white)
    }
}

extension View {
    func largeTitle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US" ]
    @State private var currentCountry = Int.random(in: 0...2)
    @State private var currentScore = 0
    @State private var selectedFlag = ""
    @State private var round = 0
    @State private var gameOver = false
    
    @State private var correct = ""
    @State private var showScore = false
        
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.4), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                Spacer()
                
                Text("Select the flag of: ")
                    .foregroundColor(.white)
                    .font(.subheadline.weight(.semibold))
                Text("\(countries[currentCountry])")
                    .largeTitle()
                
                Spacer()
                Spacer()
                Spacer()
                VStack {
                    ForEach(0..<3) { number in
                        Button {
                            selectFlag(number)
                        } label : {
                            ButtonFlag(specificCountry: countries[number])
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
            }
            .padding()
        }
        
        
        .alert(correct, isPresented: $showScore){
            Button("Continue", action: resetRound)
        } message: {
            Text("Your score is \(currentScore)")
        }
        
        .alert("Game over", isPresented: $gameOver){
            Button("Start over", action: resetGame)
        } message: {
            Text("Your final score was \(currentScore)")
        }
    }
    
    func selectFlag(_ number: Int){
        selectedFlag = countries[number]
        round += 1
        
        if(number == currentCountry){
            correct = "Correct"
            currentScore += 1
        } else {
            correct = "Wrong, that was the flag of \(selectedFlag)"
            if(currentScore > 0) {
                currentScore -= 1
            } else {
                currentScore = 0
            }
        }
        if(round < 8){
            showScore = true
        } else {
            gameOver = true
        }
    }
    
    func resetRound () {
        countries.shuffle()
        currentCountry = Int.random(in: 0...2)
    }
    func resetGame () {
        resetRound()
        round = 0
        currentScore = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
