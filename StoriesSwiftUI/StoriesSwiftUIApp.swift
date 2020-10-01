//
//  StoriesSwiftUIApp.swift
//  StoriesSwiftUI
//
//  Created by Carlos Rodriguez on 9/29/20.
//

import SwiftUI
import Firebase

@main
struct StoriesSwiftUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            StoriesView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
