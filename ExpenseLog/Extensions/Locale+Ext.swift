//
//  Locale+Ext.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 18/07/2024.
//

import Foundation

extension Locale {
    func currencySymbol(forCurrencyCode code: String) -> String? {
        guard let language = language.languageCode?.identifier else { return nil }
        let components: [String: String] = [
            NSLocale.Key.currencyCode.rawValue: code,
            NSLocale.Key.languageCode.rawValue: language
        ]
        let identifier = Locale.identifier(fromComponents: components)
        return Locale(identifier: identifier).currencySymbol
    }
}
