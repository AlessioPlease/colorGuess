//
//  ContentView.swift
//  Color guess
//
//  Created by Alessio De Gaetano on 20/02/2020.
//  Copyright © 2020 Alessio De Gaetano. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var randomColors = RandomColor()
    @State var rGuess: Double   // queste tre variabili vanno inizializzate,
    @State var gGuess: Double   // ma se non lo faccio qui le posso inizializzare
    @State var bGuess: Double   // quando chiamo ContentView
    
    @State var showAlert = false
    @State var refresh = false
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                VStack {
                    if refresh {
                        Color(red: randomColors.getrRandom(),
                              green: randomColors.getgRandom(),
                              blue: randomColors.getbRandom())
                    }
                    else {
                        Color(red: randomColors.getrRandom(),
                              green: randomColors.getgRandom(),
                              blue: randomColors.getbRandom())
                    }
                    
                    if self.showAlert {
                        Text("R: \(Int(randomColors.getrRandom() * 255.0)) " +
                             "G: \(Int(randomColors.getgRandom() * 255.0)) " +
                             "B: \(Int(randomColors.getbRandom() * 255.0))")
                        .font(Font.system(size: 15))
                    } else {
                        Text("Match this color")
                        .font(Font.system(size: 15))
                    }
                    
                }
                VStack {
                    Color(red: rGuess, green: gGuess, blue: bGuess)
                    
                    Text("R: \(Int(rGuess * 255.0)) " +
                         "G: \(Int(gGuess * 255.0)) " +
                         "B: \(Int(bGuess * 255.0))")
                        .font(Font.system(size: 15))
                }
            }//.padding(.horizontal)
            
            HStack(spacing: 50.0) {
                Button(action: {
                    self.start();
                    self.refresh.toggle()
                    self.rGuess = 0.5
                    self.gGuess = 0.5
                    self.bGuess = 0.5
                }) {
                    Text("Start")
                        .foregroundColor(Color("myCustomColor"))
                }
                
                Button(action: {self.showAlert = true}) {
                    Text("Submit!")
                        .font(Font.system(size: 25))
                        .fontWeight(.heavy)
                        .foregroundColor(Color("myCustomColor"))
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Your Score"), message: Text(String(computeScore())))
                }
                Button(action: {
                    DispatchQueue.global(qos: .userInteractive).async {
                        self.refresh.toggle()
                        for i in 0...255 {
                            for j in 0...255 {
                                for k in 0...255 {
                                    self.rGuess = Double(i) / 255
                                    self.gGuess = Double(j) / 255
                                    self.bGuess = Double(k) / 255
                                    self.refresh.toggle()
                                }
                            }
                        }
                    }
                    
                    
                }) {
                    Text("RGB")
                        .foregroundColor(Color("myCustomColor"))
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .padding(.leading, 0)    //--------------------- RIPRISTINA
            
            
            colorSlider(colorValue: $rGuess, color: .red)
            colorSlider(colorValue: $gGuess, color: .green)
            colorSlider(colorValue: $bGuess, color: .blue)
        }.edgesIgnoringSafeArea(.top)
    }
    
    
    
    func start() {
        self.randomColors.newRandomColors()
    }
    
    
    
    func computeScore() -> Int {
        
      let rDelta = rGuess - randomColors.getrRandom()
      let gDelta = gGuess - randomColors.getgRandom()
      let bDelta = bGuess - randomColors.getbRandom()
      let diff = sqrt(rDelta * rDelta + gDelta * gDelta + bDelta * bDelta)
        return Int((1.0 - diff) * 100.0 + 0.5) < 100 ? Int((1.0 - diff) * 100.0 + 1.5) : Int((1.0 - diff) * 100.0 + 0.5)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
            .previewDevice("iPhone 13 Pro Max")
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
    }
}



struct colorSlider: View {
    
    @Binding var colorValue: Double
    var color: Color
    
    var body: some View {
        HStack {
            Text("0")
                .font(Font.system(size: 13))
                .foregroundColor(color)
            
            Slider(value: $colorValue)
                .accentColor(color)
            
            Text("255")
                .font(Font.system(size: 13))
                .foregroundColor(color)
        }.padding(.horizontal)
    }
}
