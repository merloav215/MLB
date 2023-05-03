//
//  MLBApp.swift
//  MLB
//
//  Created by Avery Merlo on 4/18/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct MLBApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}

//TODO: MAKE LAUNCH SCREEN SMALLER

//TODO: MAKE FAVORITES SCREEN

