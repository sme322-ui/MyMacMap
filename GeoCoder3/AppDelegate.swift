//
//  AppDelegate.swift
//  GeoCoder3
//
//  Created by Sie monyan on 2022/1/22.
//
import UIKit
import CoreLocation
import UserNotifications
import HealthKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    var apiKey = "ZEJtsYY2yTKTa8tUQ9TfMI1Jl7e6JfD5"
    let container = NSPersistentContainer(name:"FoodPin")
    var db: OpaquePointer?=nil
    
    var statement :OpaquePointer? = nil
  let locationManager = CLLocationManager()
    
    var persistentContainer: NSPersistentContainer?
    lazy var persistentContianer: NSPersistentContainer = {
        let container = NSPersistentContainer(name:"CoreDataDemo")
        container.loadPersistentStores(completionHandler: {(NSPersistentStoreDescription,error) in
            if let error = error as NSError?{
                fatalError("Unresolved error \(error),\(error.userInfo)")
                
            }
        })
        return container
    }()
    
    func saveContext(){
        let context = persistentContianer.viewContext
        if context.hasChanges{
            do{
                try context.save()}catch{
                    
                    
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror),\(nserror.userInfo)")
                    
                    
                    
                }
            }
        }

 

    private func application(application:UIApplication,openURL url:NSURL,sourceApplication:String?,annotation:AnyObject?)->Bool{
        let message = url.host?.utf8CString
        let alertController = UIAlertController(title: "Incoming Message", message: "", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(okAction)
        
        window?.rootViewController?.presentedViewController
        return true
    }
    private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        

        return true
    }
    // MARK: UISceneSession Lifecycle
   
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
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
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let fm:FileManager = FileManager()
        let src:String = Bundle.main.path(forResource: "Personal", ofType: "db")!
        let dst:String = NSHomeDirectory()+"/Documents/Personal.db"
        
        if !fm.fileExists(atPath: dst) {
            do {
                try fm.copyItem(atPath: src, toPath: dst)
            } catch _ {
            }
        }
        
        return true
    }

}

