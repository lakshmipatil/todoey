//
//  AppDelegate.swift
//  todoey
//
//  Created by Basavaraj Soppannavar on 11/21/18.
//  Copyright © 2018 Lakshmi B S. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
       // print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
        do{
            _ = try Realm()
        } catch{
            print("error in installing REalm\(error)")
        }
        
        return true
    }
    
}
