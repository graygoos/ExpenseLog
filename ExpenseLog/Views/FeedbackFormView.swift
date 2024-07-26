//
//  FeedbackFormView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 26/07/2024.
//

import SwiftUI

struct FeedbackFormView: View {
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            WebView(urlString: "https://docs.google.com/forms/d/e/1FAIpQLScdKRWA8d4NC6nc3_2w62jJhQMZzNL-18_WERSHtMLwPMluXw/viewform?usp=sf_link", isLoading: $isLoading)
                .edgesIgnoringSafeArea(.all)
            
            if isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    FeedbackFormView()
}
