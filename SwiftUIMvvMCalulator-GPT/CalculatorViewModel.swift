//
//  CalculatorViewModel.swift
//  SwiftUIMvvMCalulator-GPT
//
//  Created by Gabriel Alan Collins on 2023-06-10.
//

import SwiftUI
import Combine

class CalculatorViewModel: ObservableObject {
    @Published var model: CalculatorModel = CalculatorModel()
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""

    var result: String {
        return model.result?.description ?? "0"
    }

    func digitTapped(_ digit: String) {
        guard let digitInt = Int(digit) else { return }
        model.setOperand(digitInt)
    }

    func operationTapped(_ operation: String) {
        model.performOperation(operation)
        if model.errorOccurred {
            model.errorOccurred = true
            showAlert = true
            errorMessage = "Non-integer result. Operation not allowed."
            model.clearError()
        }
    }



}


