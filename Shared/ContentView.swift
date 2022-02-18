//
//  ContentView.swift
//  Shared
//
//  Created by Jeff Terry on 12/31/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var intval = 0.0
    @State var totalGuesses = 0.0
    @State var totalIntegral = 0.0
    @State var lowerBoundVal = 1.0
    @State var upperBoundVal = 1.0
    @State var minVal = 1.0
    @State var maxVal = 1.0
    @State var guessString = "guesses"
    @State var lowerBoundValString = "lower bound"
    @State var upperBoundValString = "upper bound"
    @State var minValString = "should be 0 if function is positively defined"
    @State var maxValString = "maximum value of function in bounds of integration"
    @State var totalGuessString = "0"
    @State var intValString = "0.0"
    
    
    // Setup the GUI to monitor the data from the Monte Carlo Integral Calculator
    @ObservedObject var monteCarloInt = MonteCarloInt(withData: true)
    
    //Setup the GUI View
    var body: some View {
        HStack{
            
            VStack{
                
                VStack(alignment: .center) {
                    Text("Guesses")
                        .font(.callout)
                        .bold()
                    TextField("# Guesses", text: $guessString)
                        .padding()
                }
                .padding(.top, 5.0)
                
                VStack(alignment: .center) {
                    Text("Lower Bound")
                        .font(.callout)
                        .bold()
                    TextField("lower bound of integral", text: $lowerBoundValString)
                        .padding()
                }
                .padding(.top, 5.0)
                
                VStack(alignment: .center) {
                    Text("Upper Bound")
                        .font(.callout)
                        .bold()
                    TextField("upper bound of integral", text: $upperBoundValString)
                        .padding()
                }
                .padding(.top, 5.0)
                
                VStack(alignment: .center) {
                    Text("Minimum Value")
                        .font(.callout)
                        .bold()
                    TextField("should be 0 if function is positively defined", text: $minValString)
                        .padding()
                }
                .padding(.top, 5.0)
                
                VStack(alignment: .center) {
                    Text("Maximum Value")
                        .font(.callout)
                        .bold()
                    TextField("maximum value of function in bounds of integration", text: $maxValString)
                        .padding()
                }
                .padding(.top, 5.0)
                
                VStack(alignment: .center) {
                    Text("Total Guesses")
                        .font(.callout)
                        .bold()
                    TextField("# Total Guesses", text: $totalGuessString)
                        .padding()
                }
                
                VStack(alignment: .center) {
                    Text("Integral")
                        .font(.callout)
                        .bold()
                    TextField("Value of Integral", text: $intValString)
                        .padding()
                }
                
                Button("Cycle Calculation", action: {Task.init{await self.calculatePi()}})
                    .padding()
                    .disabled(monteCarloInt.enableButton == false)
                
                Button("Clear", action: {self.clear()})
                    .padding(.bottom, 5.0)
                    .disabled(monteCarloInt.enableButton == false)
                
                if (!monteCarloInt.enableButton){
                    
                    ProgressView()
                }
                
                
            }
            .padding()
            
            //DrawingField
            
            
            drawingView(redLayer:$monteCarloInt.insideData, blueLayer: $monteCarloInt.outsideData, upperBound: $upperBoundValString, lowerBound: $lowerBoundValString, min: $minValString, max: $maxValString)
                .padding()
                .aspectRatio(1, contentMode: .fit)
                .drawingGroup()
            // Stop the window shrinking to zero.
            Spacer()
            
        }
    }
    
    func calculatePi() async {
        
        
        monteCarloInt.setButtonEnable(state: false)
        
        monteCarloInt.guesses = Int(guessString)!
//        $monteCarloInt.lowerBound = lowerBoundVal
//        $monteCarloInt.upperBound = upperBoundVal
//        $monteCarloInt.min = minVal
//        $monteCarloInt.max = maxVal
        monteCarloInt.totalGuesses = Int(totalGuessString) ?? Int(0.0)
        
        await monteCarloInt.calculateIntVal(lowerBoundVal: Double(lowerBoundValString)!, upperBoundVal: Double(upperBoundValString)!, minVal: Double(minValString)!, maxVal: Double(maxValString)!)
        
        totalGuessString = monteCarloInt.totalGuessesString
        
        intValString = monteCarloInt.IntValString
        
        monteCarloInt.setButtonEnable(state: true)
        
    }
    
    func clear(){
        
        guessString = "guesses"
        totalGuessString = "0.0"
        intValString =  ""
        lowerBoundValString = "lower bound"
        upperBoundValString = "upper bound"
        minValString = "should be 0 if function is positively defined"
        maxValString = "maximum value of function in bounds of integration"
        monteCarloInt.totalGuesses = 0
        monteCarloInt.totalIntegral = 0.0
        monteCarloInt.insideData = []
        monteCarloInt.outsideData = []
        monteCarloInt.firstTimeThroughLoop = true
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
