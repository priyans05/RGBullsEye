//
//  ContentView.swift
//  RGBullsEye
//
//  Created by PRIYANS on 30/3/20.
//  Copyright © 2020 PRIYANS. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var rTarget = Double.random(in: 0..<1)
    @State var gTarget = Double.random(in: 0..<1)
    @State var bTarget = Double.random(in: 0..<1)
    
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    @State var showAlert = false
    
    @ObservedObject var timer = TimeCounter()
    
    func computeScore()-> Int {
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
        
        return Int((1-diff) * 100.0 + 0.5)
    }
    
    func isPresented() -> Alert {
        return Alert(title: Text("your Score"), message: Text(String(computeScore())), primaryButton: .default(Text("Change Color"), action: {
            self.rTarget = Double.random(in: 0..<1)
            self.gTarget = Double.random(in: 0..<1)
            self.bTarget = Double.random(in: 0..<1)
            self.timer.resetTimer()
        }), secondaryButton: .default(Text("Try Again"), action: {self.timer.resetTimer()}))
        
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Color(red: rTarget, green: gTarget, blue: bTarget)
                        .cornerRadius(10.0)
                self.showAlert ? Text("R: \(Int(rTarget * 255.0))"
                      + "  G: \(Int(gTarget * 255.0))"
                      + "  B: \(Int(bTarget * 255.0))")
                      : Text("Match this color")
                }
                VStack {
                    ZStack(alignment: .center) {
                        Color(red: rGuess, green: gGuess, blue: bGuess)
                            .cornerRadius(10.0)
                        Text(String(timer.counter))
                        .padding(.all, 5)
                        .background(Color.white)
                        .mask(Circle())
                            .foregroundColor(.black)
                        
                    }
                    Text("R: \(Int(rGuess * 255)) G: \(Int(gGuess * 255)) B: \(Int(gGuess * 255))")
                }
            }.padding()
            Button(action: {self.showAlert = true; self.timer.killTimer()}) {
                Text("Hit Me!")
                    .foregroundColor(.white)
                    .frame(width: 100, height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(red: rTarget, green: gTarget, blue: bTarget), Color(red: rGuess, green: gGuess, blue: bGuess)]), startPoint: .bottomTrailing, endPoint: .topLeading))
                    .cornerRadius(10.0)
                
            }
            .alert(isPresented: $showAlert) { isPresented()
            }
            
            VStack {
                ColorSlider(value: $rGuess, textColor: .red)
                ColorSlider(value: $gGuess, textColor: .green)
                ColorSlider(value: $bGuess, textColor: .blue)
            }.padding(.horizontal)
            
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
            .previewLayout(.fixed(width: 568, height: 320))
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    var body: some View {
        HStack {
            Text("0").foregroundColor(textColor)
            Slider(value: $value)
                .background(textColor)
                .cornerRadius(10.0)
            Text("255").foregroundColor(textColor)
        }
    }
}
