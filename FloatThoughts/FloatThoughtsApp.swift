//
//  FloatThoughtsApp.swift
//  FloatThoughts
//
//  Created by Tasawar Saraf on 3/27/25.
//

import SwiftUI
import Firebase

@main
struct FloatThoughtsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            
            NavigationStack{
                RootView()
            }
            
        }
    }
}




class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
        
    }
    
}

