//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nicolas Papegaey on 26/05/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    @State private var opacityValue = 0.2
    @State private var rotationDegree = 0.0
    
    // Labels for accessibility
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag").largeTitle()
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(viewModel.countries[viewModel.correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            viewModel.flagTapped(number)
                            viewModel.selectedFlag = number
                            if number == viewModel.correctAnswer {
                                withAnimation {
                                    rotationDegree += 360
                                }
                                rotationDegree = 0
                                withAnimation {
                                    opacityValue = 0.2
                                }
                            }
                        } label: {
                            FlagImage(country: viewModel.countries[number])
                                .rotationEffect(Angle(degrees: number == viewModel.selectedFlag ? rotationDegree : 0))
                                .opacity((viewModel.selectedFlag != -1 && viewModel.selectedFlag != number) ? opacityValue : 1)
                                .scaleEffect((viewModel.selectedFlag != -1 && viewModel.selectedFlag != number) ? opacityValue : 1)
                                .accessibilityLabel(labels[viewModel.countries[number], default: "Unknown flag"])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(viewModel.score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(viewModel.scoreTitle, isPresented: $viewModel.showingScore) {
            Button("Continue", action: viewModel.askQuestion)
        } message: {
            Text("Your score is \(viewModel.score)")
        }
        .alert(viewModel.scoreTitle, isPresented: $viewModel.showingGameOver) {
            Button("Play again", action: viewModel.restartGame)
        } message: {
            Text("Your final score is \(viewModel.score)")
        }
    }
    
    
}

struct LargeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.bold))
            .foregroundColor(.white)
    }
}

extension View {
    func largeTitle() -> some View {
        modifier(LargeTitle())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
