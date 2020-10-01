//
//  WebView.swift
//  StoriesSwiftUI
//
//  Created by Carlos Rodriguez on 9/29/20.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else { return WKWebView() }
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.load(request)
        return wkWebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
