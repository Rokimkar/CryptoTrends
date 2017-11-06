//
//  AppDelegate.swift
//  CryptoTrends
//
//  Created by S@nchit on 24/09/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit
import Firebase
import MoEngage_iOS_SDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //Moengage
        
        #if DEBUG
            MoEngage.sharedInstance().initializeDev(withApiKey: "WTZ62TE0EFOZDUBSIPR6FASN", in: application, withLaunchOptions: launchOptions, openDeeplinkUrlAutomatically: true)
        #else
            MoEngage.sharedInstance().initializeProd(withApiKey: "WTZ62TE0EFOZDUBSIPR6FASN", in: application, withLaunchOptions: launchOptions, openDeeplinkUrlAutomatically: true)
        #endif
        
        self.sendAppStatusToMoEngage()
    MoEngage.sharedInstance().setUserUniqueID(UIDevice.current.identifierForVendor?.uuidString)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       MoEngage.sharedInstance().stop(application)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        MoEngage.sharedInstance().applicationWillEnterForeground(application)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        MoEngage.sharedInstance().applicationBecameActiveinApplication(application)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        MoEngage.sharedInstance().applicationTerminated(application)
    }
    
    // Mark : Supporting functions

    func initialiseGoogleAdMob(){
        FirebaseApp.configure()
        GADMobileAds.configure(withApplicationID: "ca-app-pub-6026686664345507~4614220710")
    }

    func getAppVersion () -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    func saveAppVersionToDefaults () {
        UserDefaults.standard.set(self.getAppVersion(), forKey: "app version")
        UserDefaults.standard.synchronize()
    }
    
    func sendAppStatusToMoEngage () {
        if((UserDefaults.standard.value(forKey:"app version") == nil)){
            MoEngage.sharedInstance().appStatus(INSTALL)
            self.saveAppVersionToDefaults()
            return
        }
        
        if(self.getAppVersion() != (UserDefaults.standard.value(forKey:"app version") as! String)){
            MoEngage.sharedInstance().appStatus(UPDATE)
            self.saveAppVersionToDefaults()
        }
    }
}

