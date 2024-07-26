//
//  FeedbackForm.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 25/03/2024.
//

import SwiftUI

struct FeedbackForm: View {
    var body: some View {
        Form {
            Section(header: Text("via email app")) {
                HStack {
                    Image(systemName: "envelope")
                    Text("Email Developer")
                    Spacer()
                }
                .onTapGesture {
                    sendFeedback()
                }
            }
            
            Section(header: Text("via Google form")) {
                NavigationLink(destination: FeedbackFormView()) {
                    Text("Fill Feedback form")
                        .toolbar(.hidden, for: .tabBar)
                }
            }
            .toolbar(.hidden, for: .tabBar)
        }
        .navigationTitle("Feedback")
    }
    
    func sendFeedback() {
        if let url = URL(string: "mailto:femialiu713@gmail.com") {
            UIApplication.shared.open(url)
        }
    }
}



#Preview {
    FeedbackForm()
}
