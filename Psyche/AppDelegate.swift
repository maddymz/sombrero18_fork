//
//  AppDelegate.swift
//  Psyche
//
//  Created by Julia Liu on 12/13/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
import CoreData
import TwitterKit
import SDWebImage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        TWTRTwitter.sharedInstance().start(withConsumerKey: "F4jAel6EzmqsS5qBfe99sI5VX", consumerSecret: "x1h1YucRjVKyumulYqP27zObQ2Ir1TmdP84le0Emx6tvfxcnmE")
        
        //handle high memory usage by SDWebimgae- by Madhukar Raj 03/11/2019
//        SDImageCache.shared().config.maxCacheAge = 3600 * 24 * 7 //1 Week
//        
//        SDImageCache.shared().maxMemoryCost = 1024 * 1024 * 20 //Aprox 20 images
//        
//        //SDImageCache.shared().config.shouldCacheImagesInMemory = false //Default True => Store images in RAM cache for Fast performance
//        
//        SDImageCache.shared().config.shouldDecompressImages = false
//        
//        SDWebImageDownloader.shared().shouldDecompressImages = false
//        
//        SDImageCache.shared().config.diskCacheReadingOptions = NSData.ReadingOptions.mappedIfSafe
        
        //ViewControllerBased status bar to NO in info.plist
        UIApplication.shared.statusBarStyle = .lightContent
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
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
        self.saveContext()
    }
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Psyche")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    

    

}

//extension UINavigationBar {
//
//    func setGradientBackground(colors: [UIColor]) {
//
//        var updatedFrame = bounds
//        updatedFrame.size.height += self.frame.origin.y
//        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
//
//        setBackgroundImage(gradientLayer.creatGradientImage(), for: UIBarMetrics.default)
//    }
//}
//
//extension CAGradientLayer {
//
//    convenience init(frame: CGRect, colors: [UIColor]) {
//        self.init()
//        self.frame = frame
//        self.colors = []
//        for color in colors {
//            self.colors?.append(color.cgColor)
//        }
//        startPoint = CGPoint(x: 0, y: 0)
//        endPoint = CGPoint(x: 0, y: 1)
//    }
//
//    func creatGradientImage() -> UIImage? {
//
//        var image: UIImage? = nil
//        UIGraphicsBeginImageContext(bounds.size)
//        if let context = UIGraphicsGetCurrentContext() {
//            render(in: context)
//            image = UIGraphicsGetImageFromCurrentImageContext()
//        }
//        UIGraphicsEndImageContext()
//        return image
//    }
//
//}
//
