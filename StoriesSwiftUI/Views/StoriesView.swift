//
//  StoriesView.swift
//  StoriesSwiftUI
//
//  Created by Carlos Rodriguez on 9/29/20.
//

import SwiftUI

struct StoriesView: View {
    @State var stories: [Story] = []
    @State var refreshControl = UIRefreshControl()
    var body: some View {
        NavigationView {
            VStack {
                RefreshScrollView(refreshControl: self.$refreshControl, stories: self.$stories)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView()
    }
}
