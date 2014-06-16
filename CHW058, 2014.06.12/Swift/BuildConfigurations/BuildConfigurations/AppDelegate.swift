//
//  AppDelegate.swift
//  BuildConfigurations
//
//  Created by Mikael Konutgan on 12/06/14.
//  Copyright (c) 2014 Mikael Konutgan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.rootViewController = UIViewController()
        self.window!.makeKeyAndVisible()
        
        // Build Configurations
        
    #if arch(x86_64)
        println("64-bit Intel")
    #elseif arch(i386)
        println("32-bit Intel")
    #elseif arch(arm)
        println("32-bit ARM")
    #elseif arch(arm64)
        println("64-bit ARM")
    #else
        println("Unknown")
    #endif
        
    #if os(OSX)
        println("OS X")
    #elseif os(iOS)
        println("iOS")
    #else
        println("Unknown")
    #endif
        
    #if staging
        println("Staging")
    #endif
            
        return true
    }
}
