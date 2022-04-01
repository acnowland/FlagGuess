//
//  ContentView.swift
//  FlagGuess
//
//  Created by Adam Nowland on 4/1/22.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US" ]
    @State private var currentCountry = Int.random(in: 0...2)
    @State private var currentScore = 0
    
    @State private var correct = ""
    @State private var showScore = false
        
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .indigo], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                
                Text("Select the flag of: ")
                    .foregroundColor(.white)
                    .font(.subheadline.weight(.semibold))
                Text("\(countries[currentCountry])")
                    .foregroundColor(.white)
                    .font(.title.weight(.heavy))
                
                Spacer()
                
                ForEach(0..<3) { number in
                    Button {
                        selectFlag(number)
                    } label : {
                        Image(countries[number])
                            .renderingMode(.original)
                    }
                    .padding()
                    .clipShape(Capsule())
                    .shadow(radius: 5)
                }
                Spacer()
            }
        }
        .alert(correct, isPresented: $showScore){
            Button("Continue", action: resetRound)
        } message: {
            Text("Your score is \(currentScore)")
        }
    }
    
    func selectFlag(_ number: Int){
        if(number == currentCountry){
            correct = "Correct"
            currentScore += 1
        } else {
            correct = "Wrong"
        }
        showScore = true
    }
    
    func resetRound () {
        countries.shuffle()
        currentCountry = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
