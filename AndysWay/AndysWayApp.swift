//
//  AndysWayApp.swift
//  AndysWay
//
//  Created by Christian Grise on 9/27/24.
//

import SwiftUI
import SwiftData

let currentEnvironment: EnvironmentType = .development

@main
struct AndysWayApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(loginViewModel)
        }
    }
}
