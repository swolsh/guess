//
//  ContentView.swift
//  Guess
//
//  Created by A M on 09.02.2023.
//

import SwiftUI

struct BigBlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.black)
    }
}
extension View {
    func bbf() -> some View {
        modifier(BigBlueFont())
    }
}

struct Img: ViewModifier {
    func body(content: Content) -> some View {
        content
            //.renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 40)
    }
}
extension View {
    func FlagImage() -> some View {
        modifier(Img())
    }
}


struct ContentView: View {
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correct = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 1, green: 0.9, blue: 0.1), location: 0.3),
                .init(color: .white, location: 1)
            ], center: .top, startRadius: 0, endRadius: 600)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .bbf()
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                        Text(countries[correct])
                            .font(.largeTitle.bold())
                        
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .FlagImage()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                
                Spacer()
                
                
                Text("Score: \(score)")
                    .foregroundColor(.black)
                    .font(.title.bold())
                
                Spacer()
                
                Button("Restart") {
                    restart()
                }
                .foregroundStyle(.secondary)
                .font(.title.bold())
                            
                
                    /*.alert(scoreTitle, isPresented: $showingScore) {
                        Button("Restart", action: restart)
                    }*/
            }
            .padding(30)
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if score < 100 {
            if number == correct {
                scoreTitle = "Correct"
                score += 10
            } else {
                scoreTitle = "Wrong, that's \(countries[number])"
            }
        } else if score == 100 {
            restart()
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correct = Int.random(in: 0...2)
    }
    
    func restart() {
        score = 0
        scoreTitle = "Finish"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
