//
//  AboutScreen.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 25/03/2024.
//

import SwiftUI

struct AboutScreen: View {
    let aboutText = "ExpenseLog is an expense logging app"
    
    var body: some View {
        HStack {
            Text("ExpenseLog ")
            Image(systemName: "creditcard.fill")
        }
    }
}

#Preview {
    AboutScreen()
}
