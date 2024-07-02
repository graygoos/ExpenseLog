//
//  ExpenseDetailTextView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 01/07/2024.
//

import SwiftUI

struct ExpenseDetailTextView: View {
    var title: String
    var detail: String
    var isCurrency: Bool = false
    var currencyCode: String? = nil
    var symbolName: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(.secondary)
                .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .leading)
            if isCurrency, let code = currencyCode {
                Text(Decimal(string: detail) ?? 0, format: .currency(code: code))
            } else {
                Text(detail)
            }
        }
    }
}

#Preview {
    ExpenseDetailTextView(title: "", detail: "")
}
