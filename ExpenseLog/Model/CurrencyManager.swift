//
//  CurrencyManager.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 18/04/2024.
//

import Foundation

class CurrencyManager: ObservableObject {
    @Published var allCurrencies: [String] = []

    init() {
        fetchCurrencies()
    }

    private func fetchCurrencies() {
        DispatchQueue.global().async {
            let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
            let currencies = locales.compactMap { $0.currency?.identifier }
            DispatchQueue.main.async {
                self.allCurrencies = currencies
            }
        }
    }
}
