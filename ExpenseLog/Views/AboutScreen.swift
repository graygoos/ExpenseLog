//
//  AboutScreen.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 25/03/2024.
//

import SwiftUI

struct AboutScreen: View {
    let aboutText = """
Welcome to ExpenseLog – your personal expense tracking companion! Developed to simplify daily expense recording, ExpenseLog was born out of a personal need to manage expenses more effectively. 
As one of our esteemed testers, you're among the first to experience ExpenseLog's intuitive features and functionalities as they develop. Over the next 90 days, we're committed to delivering weekly updates, introducing new features, refining existing ones, and addressing your valuable feedback. Our ultimate aim? To launch ExpenseLog on the App Store, complete with versions optimized for iPadOS and macOS.
Rest assured, your data's safety is our priority. ExpenseLog enables seamless data export, with robust security measures in place to protect your information.
We value your insights and invite you to actively participate in testing ExpenseLog. Your feedback plays a crucial role in shaping the app's future. Together, let's redefine expense tracking.
Thank you for joining us on this journey!

Femi
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
    }
}

#Preview {
    AboutScreen()
}
