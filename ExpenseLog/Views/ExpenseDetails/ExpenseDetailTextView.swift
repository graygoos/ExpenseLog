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
    var symbolName: String? = nil
    var quantity: Double? = nil
    var unit: String? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(.secondary)
                .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .leading)
            HStack {
                if let symbolName = symbolName {
                    Image(systemName: symbolName)
                        .foregroundStyle(.secondary)
                }
                if isCurrency, let code = currencyCode {
                    Text(Decimal(string: detail) ?? 0, format: .currency(code: code))
                } else if let quantity = quantity, let unit = unit {
                    Text("^[\(quantity, specifier: "%.2f") \(unit)](inflect: true)")
                } else {
                    Text(detail)
                }
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    ExpenseDetailTextView(title: "", detail: "")
}

//Text("^[\(quantity) \(unit)](inflect: true)")
