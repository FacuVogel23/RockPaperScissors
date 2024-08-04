//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by kqDevs on 24/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["🪨", "🧻", "✂️"]
    @State private var winningMoves = ["🧻", "✂️", "🪨"]
    @State private var currentAppChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    @State private var actualScore = 0
    @State private var questionNumber = 0
    @State private var moveResult = ""
    @State private var resultMessage = ""
    
    @State private var showingResult = false
    @State private var gameOver = false
    
    struct caseWin: View {
        var currentAppChoice: String
        
        
        var body: some View {
            Text("You should WIN against")
                .font(.title2)
                .foregroundStyle(.black.opacity(0.6))
                .bold()
            Text(currentAppChoice)
                .font(.system(size: 30))
                .padding(2)
        }
    }
    
    struct caseLose: View {
        var currentAppChoice: String
        
        
        var body: some View {
            Text("You should LOSE against")
                .font(.title2)
                .foregroundStyle(.black.opacity(0.6))
                .bold()
            Text(currentAppChoice)
                .font(.system(size: 30))
                .padding(2)
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.cyan, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                Text("Rock Paper Scissors")
                    .font(.largeTitle.bold())
                    .shadow(color: .black, radius: 14)
                    .fontDesign(.serif)
                    .foregroundStyle(.white)
                    .padding()
                    //.foregroundStyle(.thinMaterial.opacity(1))
                
                //Spacer()
                //Spacer()
                
                VStack {
                    Spacer()
                    
                    if shouldWin {
                        caseWin(currentAppChoice: moves[currentAppChoice])
                    }else {
                        caseLose(currentAppChoice: moves[currentAppChoice])
                    }
                    
                    VStack {
                        Text("SELECT YOUR MOVE")
                            .foregroundStyle(.secondary).opacity(0.8)
                            .font(.subheadline.weight(.heavy))
                            .padding(.bottom, 1)
                        
                        HStack(spacing: 50) {
                            ForEach(0..<3) { move in
                                Button {
                                    // CAMBIAR ACCION DEL BOTON
                                    buttonTapped(move)
                                    //questionNumber = flagTapped(number, questionNumber)
                                } label: {
                                    // CAMBIAR EL TEXTO(ICONOS) POR IMAGENES DESCARGADAS SI ES QUE ENCUENTRO
                                    Text("\(moves[move])")
                                        .font(.system(size: 65))
                                    //FlagImage(country: countries[number])
                                    /*
                                     Image(countries[number])
                                     .clipShape(.capsule)
                                     .shadow(radius: 5)
                                     */
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.regularMaterial.opacity(0.6))
                    .clipShape(.rect(cornerRadius: 20))
                    .padding()
                    
                    Spacer()
                    
                    Text("Your score is: \(actualScore)")
                        .font(.title)
                        .foregroundStyle(.black.opacity(0.6))
                        .fontWeight(.semibold)
                        .italic()
                    
                    //Spacer()
                }
                
                Spacer()
                Spacer()
                
                Text("Question \(questionNumber)/10")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                
                //Spacer()
            }
        }
        
        .alert(moveResult, isPresented: $showingResult) {
            Button("Continue", action: nextMove)
        } message: {
            Text("\(resultMessage)")
        }
        
        .alert(moveResult, isPresented: $gameOver) {
            Button("Restart game", action: restartGame)
        } message: {
            Text("Your final score is \(actualScore)!")
                .fontWeight(.semibold)
        }
        
    }
    
    func buttonTapped (_ move: Int) {
        if shouldWin == true && winningMoves[currentAppChoice] == moves[move] {
            if actualScore < 10 {
                actualScore += 1
                resultMessage = "You win 1 point"
            }else {
                resultMessage = "You have the maximum score"
            }
            
            moveResult = "Great choice! 👏"
            
            if questionNumber < 10 {
                showingResult = true
            }
            
        }else if shouldWin == false && (winningMoves[currentAppChoice] != moves[move]) && (winningMoves[move] == moves[currentAppChoice]) {
            if actualScore < 10 {
                actualScore += 1
                resultMessage = "You win 1 point"
            }else {
                resultMessage = "You have the maximum score"
            }
            
            moveResult = "Great choice! 👏"
            
            if questionNumber < 10 {
                showingResult = true
            }
            
        } else {
            if actualScore > 0 {
                actualScore -= 1
                resultMessage = "You lose 1 point"
            }else {
                resultMessage = "You have the minimum score"
            }
            
            moveResult = "Bad choice! 🙃"
            
            if questionNumber < 10 {
                showingResult = true
            }
        }
        
        (questionNumber > 9) ? (gameOver = true) : (questionNumber += 1)
        
        //if questionNumber > 9 {
        //    gameOver = true
        //}else {
        //    questionNumber += 1
        //}
    }
    
    func nextMove () {
        currentAppChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    func restartGame () {
        actualScore = 0
        questionNumber = 0
        currentAppChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
}



#Preview {
    ContentView()
}
