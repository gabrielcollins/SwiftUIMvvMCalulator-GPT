//
//  ContentView.swift
//  SwiftUIMvvMCalulator-GPT
//
//  Created by Gabriel Alan Collins on 2023-06-10.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var calculatorVM: CalculatorViewModel = CalculatorViewModel()
    
    var body: some View {
        CalculatorView(calculatorVM: calculatorVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

