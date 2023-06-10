//
//  CalculatorView.swift
//  SwiftUIMvvMCalulator-GPT
//
//  Created by Gabriel Alan Collins on 2023-06-10.
//

import SwiftUI

struct CalculatorView: View {
    @ObservedObject var calculatorVM: CalculatorViewModel
    
    let buttons: [[String]] = [
        ["1", "2", "3", "+"],
        ["4", "5", "6", "−"],
        ["7", "8", "9", "×"],
        ["undo", "0", "=", "÷"]
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text(calculatorVM.result)
                .font(.largeTitle)
                .padding()
            
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 20) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            if let _ = Int(button) {
                                calculatorVM.digitTapped(button)
                            } else {
                                calculatorVM.operationTapped(button)
                            }
                        }) {
                            Text(button)
                                .font(.title)
                                .frame(width: 80, height: 80)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(40)
                        }
                    }
                }
            }
        }
        .padding()
        .alert(isPresented: $calculatorVM.showAlert) {
            Alert(title: Text("Error"), message: Text(calculatorVM.errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}
