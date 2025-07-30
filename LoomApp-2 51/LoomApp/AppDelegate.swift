//
//  AppDelegate.swift
//  LoomApp
//
//  Created by chetu on 02/04/25.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseCore
import FirebaseCore
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    static let shared = AppDelegate()
    var strCurrentIndexCheck:Int = 0
    var token:String = ""
    var tokenDeviceFinal:String = ""
    var couponFlag: String = ""

    var tabbarFlag: Bool   = true
    var tabbarSearch: Bool = false
    var boolTemp:Bool      = true
    var selectedValuesByAttribute: [String: Set<String>] = [:]
    var selectedValuesMax = 5000
    var selectedValuesMin = 0
    var tabbarBag: Bool = true



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
                FirebaseApp.configure()
                Messaging.messaging().delegate = self
                UNUserNotificationCenter.current().delegate = self
                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]

                UNUserNotificationCenter.current().requestAuthorization(options: authOptions) {
                    (granted, error) in
                    guard granted else { return }
                    DispatchQueue.main.async {
                        application.registerForRemoteNotifications()
                    }
                }
                return true
        
        
        if let fontPath = Bundle.main.path(forResource: "Hero New Regular", ofType: "otf") {
            print("Font is in bundle at: \(fontPath)")
        } else {
            print("Font NOT found in bundle.")
        }
        // Override point for customization after application launch.
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardDistance = 30
        
        return true
    }
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
          print("Firebase registration token: \(String(describing: fcmToken))")
        THUserDefaultValue.userDeviceToken = fcmToken
        tokenDeviceFinal = fcmToken ?? ""
        
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


}

