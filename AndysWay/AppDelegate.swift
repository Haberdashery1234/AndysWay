//
//  AppDelegate.swift
//  AndysWay
//
//  Created by Christian Grise on 10/2/24.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureApp(for: DevelopmentConfig())
        return true
    }
}
