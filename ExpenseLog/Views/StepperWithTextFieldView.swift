//
//  StepperWithTextFieldView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 13/03/2024.
//

import SwiftUI
/*
struct StepperWithTextFieldView: View {
    @Binding var itemQty: Int
    @State private var textValue: String = ""
    
    var body: some View {
        HStack {
            Button("-") {
                if itemQty > 1 {
                    itemQty -= 1
                    textValue = "\(itemQty)"
                    updateTextValue()
                }
            }
            .padding()
            
            TextField("Quantity", text: $textValue)
                .keyboardType(.decimalPad)
                .onAppear {
                    textValue = "\(itemQty)"
                }
                .onChange(of: textValue) { newValue in
                    if let quantity = Int(newValue) {
                        itemQty = quantity
                    }
                }
                .frame(width: 50)
            
            Button("+") {
                itemQty += 1
                textValue = "\(textValue)"
                updateTextValue()
            }
            .padding()
        }
    }
    
    private func updateTextValue() {
        textValue = "\(itemQty)"
    }
}
*/
//#Preview {
//    @State var quantity: Int = 1
//    
//    StepperWithTextFieldView(itemQty: $quantity)
//}
