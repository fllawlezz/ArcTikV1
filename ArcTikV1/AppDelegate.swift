//
//  AppDelegate.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/1/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit
import CoreData
import GooglePlaces

var UIScreenWidth: CGFloat?;
var UIScreenHeight: CGFloat?;

var standard: UserDefaults?;

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSPlacesClient.provideAPIKey("AIzaSyDFRHQiAMAnVk5BLgySA1V5XSBUbotNX14")
//        GMSServices.provideAPIKey("AIzaSyDFRHQiAMAnVk5BLgySA1V5XSBUbotNX14");
        
        window = UIWindow(frame: UIScreen.main.bounds);
        window?.makeKeyAndVisible();
        
        UIScreenWidth = UIScreen.main.bounds.width;
        UIScreenHeight = UIScreen.main.bounds.height;
        
        standard = UserDefaults.standard;
        
        let userID = standard?.object(forKey: "userID");
        if(userID != nil){
            populateUser();
            let customTab = CustomTabBar();
            window?.rootViewController = customTab;
//            let layout = UICollectionViewFlowLayout();
//            let reviewPage = ReviewPage(collectionViewLayout: layout);
//            let requirementsPage = RequirementsPage();
//            requirementsPage.fromEventsInfo = true;
//            let uploadImagesPage = UploadImagesPage();
//            let thingsToBringPage = ThingsToBringPage();
//            let navigationController = UINavigationController(rootViewController: uploadImagesPage);
//            navigationController.navigationBar.isTranslucent = false;
//            navigationController.navigationBar.barStyle = .blackTranslucent;
//            navigationController.navigationBar.tintColor = UIColor.white;
//            navigationController.navigationBar.barTintColor = UIColor.appBlue;

//            window?.rootViewController = navigationController;
        }else{
            let loginViewController = LoginPage();
            let startingNavigationController = UINavigationController(rootViewController: loginViewController);
            startingNavigationController.isNavigationBarHidden = true;
            window?.rootViewController = startingNavigationController;
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
//        self.saveContext()
    }
}

