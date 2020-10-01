//
//  RefreshScrollView.swift
//  StoriesSwiftUI
//
//  Created by Carlos Rodriguez on 9/29/20.
//

import SwiftUI

struct RefreshScrollView: UIViewRepresentable {
    
    @Binding var refreshControl: UIRefreshControl
    @Binding var stories: [Story]
    
    class Coordinator: NSObject {
        @objc func update() {
            NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return RefreshScrollView.Coordinator()
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        // height of each item is 40 so data.count items = 40 * stories.count
        // spacing between each item is 15 so + 15 * stories.count
        // updating height dynamically for no of items...
        let height = CGFloat(40 * stories.count) + CGFloat(15 * stories.count)
        
        let view = UIScrollView()
        refreshControl.addTarget(context.coordinator, action: #selector(context.coordinator.update), for: .valueChanged)
        view.showsVerticalScrollIndicator = false
        view.refreshControl = refreshControl
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: height)
        let child = UIHostingController(rootView: StoriesRefreshListView(refreshControl: self.$refreshControl, stories: self.$stories))
        child.view.frame = CGRect(x: 0, y:0, width: UIScreen.main.bounds.width, height: height)
        child.view.backgroundColor = .clear
        view.addSubview(child.view)
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // height of each item is 40 so data.count items = 40 * stories.count
        // spacing between each item is 15 so + 15 * stories.count
        // updating height dynamically for no of items...
        let height = CGFloat(40 * stories.count) + CGFloat(15 * stories.count)
        
        // make view will only be called once so we need to update the ui...
        uiView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: height)
        for i in 0..<uiView.subviews.count {
            // we need to resize all subviews also...
            uiView.subviews[i].frame = CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width, height: height)
        }
    }
}
