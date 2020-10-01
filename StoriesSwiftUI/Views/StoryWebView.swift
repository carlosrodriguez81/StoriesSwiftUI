//
//  StoryWebView.swift
//  StoriesSwiftUI
//
//  Created by Carlos Rodriguez on 9/29/20.
//

import SwiftUI

struct StoryWebView: View {
    let url: String?
    var body: some View {
        WebView(url: url ?? "")
    }
}

struct StoryWebView_Previews: PreviewProvider {
    static var previews: some View {
        StoryWebView(url: "https://www.google.com")
    }
}
