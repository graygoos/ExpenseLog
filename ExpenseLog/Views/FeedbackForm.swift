//
//  FeedbackForm.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 25/03/2024.
//

import SwiftUI
import WebKit

struct FeedbackForm: View {
    var body: some View {
        Text("You can send the developer feedback at: femialiu713@gmail.com or use the Google form below. Gracias 🙏🏽")
        WebView(urlString: "https://docs.google.com/forms/d/e/1FAIpQLScdKRWA8d4NC6nc3_2w62jJhQMZzNL-18_WERSHtMLwPMluXw/viewform?usp=sf_link")
            .edgesIgnoringSafeArea(.all)
            .toolbar(.hidden, for: .tabBar)
    }
}

struct WebView: UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
    
    let urlString: String
    
    func makeUIView(context: Context) -> some WKWebView {
        let webView = WKWebView()
        return webView
    }
}

#Preview {
    FeedbackForm()
}
