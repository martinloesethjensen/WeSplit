//
//  ContentView.swift
//  WeSplit
//
//  Created by Martin Jensen on 30/04/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages: [Int] = [5, 10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let people = Double(numberOfPeople + 2)
        let tip = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tip
        let grandTotal = checkAmount + tipValue
        let totalPerPerson = grandTotal / people
        
        return totalPerPerson
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "DKK"))
                        .keyboardType(.numberPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople, ) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "DKK"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
