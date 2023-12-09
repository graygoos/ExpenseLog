//
//  CurrencyPicker.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 29/11/2023.
//

import SwiftUI

struct CurrencyPicker: View {
    @State private var selectedCurrency = "NGN"
    
    let availableCurrencies: [String] = {
        let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        return locales.compactMap { $0.currency?.identifier }
    }()
    
    var body: some View {
        Picker("Select currency", selection: $selectedCurrency) {
            ForEach(availableCurrencies, id: \.self) { currencyCode in
                Text("\(currencyCode)")
                    .tag(currencyCode)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .border(.accent)
    }
    
    func currencyName(currencyCode: String) -> String {
        let locale = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currencyCode]))
        return locale.localizedString(forCurrencyCode: currencyCode) ?? currencyCode
    }
}

#Preview {
    CurrencyPicker()
}
