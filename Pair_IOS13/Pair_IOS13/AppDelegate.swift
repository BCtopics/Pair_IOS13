//
//  AppDelegate.swift
//  Pair_IOS13
//
//  Created by Bradley GIlmore on 6/30/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        PersonController.shared.saveToPersistentStore()
    }
    
}

