//
//  FeedbackFormView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 26/07/2024.
//

import SwiftUI
import WebKit

struct FeedbackFormView: View {
    var body: some View {
        WebView(urlString: "https://docs.google.com/forms/d/e/1FAIpQLScdKRWA8d4NC6nc3_2w62jJhQMZzNL-18_WERSHtMLwPMluXw/viewform?usp=sf_link")
            .edgesIgnoringSafeArea(.all)
            .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    FeedbackFormView()
}
