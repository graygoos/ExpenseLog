//
//  AboutScreen.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 25/03/2024.
//

import SwiftUI

struct AboutScreen: View {
    let aboutText = """
Welcome to ExpenseLog – your personal expense tracking companion! We're dedicated to simplifying expense recording for your convenience. Join us as we develop and refine ExpenseLog over the next 90 days, delivering weekly updates and incorporating your valuable feedback. Our goal? To launch ExpenseLog on the App Store, ensuring your data's safety with seamless export and robust security measures. Your insights are crucial in shaping ExpenseLog's future. Let's redefine expense tracking together. Thank you for joining us on this journey!

Femi

Copyright ©2024 Femi Aliu. All rights reserved.
"""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Text(aboutText)
                }
                .padding()
            }
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    AboutScreen()
}
