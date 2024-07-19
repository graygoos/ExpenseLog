//
//  StepperWithTextFieldView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 13/03/2024.
//

import SwiftUI

struct StepperWithTextFieldView: View {
    @Binding var itemQty: Double
    @State private var textValue: String = ""
    @State private var textFieldWidth: CGFloat = 60 // Start with minimum width
    
    let minWidth: CGFloat = 70
    let maxWidth: CGFloat = 100
    
    var body: some View {
        HStack(spacing: 0) {
            Text("Quantity")
            Spacer()
            Button(action: {
                decrementQuantity()
            }) {
                Image(systemName: "minus")
                    .foregroundColor(.primary)
                    .frame(width: 32, height: 32)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .buttonStyle(BorderlessButtonStyle())
            .padding(.trailing, 8)
            
            TextField("Quantity", text: $textValue)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.center)
                .frame(width: textFieldWidth)
                .padding(4)
                .background(
                    GeometryReader { geometry in
                        Color.clear.preference(key: WidthPreferenceKey.self, value: geometry.size.width)
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .onAppear(perform: updateTextValue)
                .onChange(of: textValue) { _, newValue in
                    if let quantity = Double(newValue.replacingOccurrences(of: ",", with: ".")) {
                        itemQty = validateQuantity(quantity)
                    }
                    updateTextFieldWidth()
                }
            
            Button(action: {
                itemQty += 1
                updateTextValue()
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.primary)
                    .frame(width: 32, height: 32)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .buttonStyle(BorderlessButtonStyle())
            .padding(.leading, 8)
        }
        .padding(.vertical, 4)
        .onPreferenceChange(WidthPreferenceKey.self) { width in
            updateTextFieldWidth(contentWidth: width)
        }
    }
    
    private func decrementQuantity() {
        if itemQty > 1 {
            itemQty -= 1
        } else if itemQty > 0 {
            itemQty = max(0, itemQty - 0.1)
        }
        updateTextValue()
    }
    
    private func validateQuantity(_ quantity: Double) -> Double {
        return max(0, quantity)
    }
    
    private func updateTextValue() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        textValue = formatter.string(from: NSNumber(value: itemQty)) ?? ""
        updateTextFieldWidth()
    }
    
    private func updateTextFieldWidth(contentWidth: CGFloat? = nil) {
        let newWidth = contentWidth ?? (textValue as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)]).width + 16 // 16 for padding
        textFieldWidth = min(max(newWidth, minWidth), maxWidth)
    }
}

struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    @State var quantity: Double = 1
    
    return StepperWithTextFieldView(itemQty: $quantity)
}
