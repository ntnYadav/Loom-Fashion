//
//  LMTabBar.swift
//  LoomApp
//
//  Created by Flucent tech on 02/04/25.
//

import UIKit

class LMTabBarVC: UITabBarController {
    
    var upperLineView: UIView!
    
    let spacing: CGFloat = 12

    override func viewDidLoad() {
        super.viewDidLoad()
       // view.backgroundColor = .systemBackground

        // Setup tab bar appearance
//        if #available(iOS 15.0, *) {
//            let appearance = UITabBarAppearance()
//            appearance.configureWithOpaqueBackground()   // Remove blur/translucency
//            appearance.backgroundColor = .white          // Set your desired color
//            
//            // Remove default selection highlight (gray background)
//            appearance.selectionIndicatorTintColor = .clear
//            
//            tabBar.standardAppearance = appearance
//            tabBar.scrollEdgeAppearance = appearance
//        } else {
//                 tabBar.barTintColor = .white
//                 tabBar.isTranslucent = false
////                 tabBar.selectionIndicatorImage = UIImage()  // remove default selection image
////                 tabBar.shadowImage = UIImage()              // remove shadow line if needed
////                 tabBar.backgroundImage = UIImage()  
//            // Remove selection indicator image to avoid gray background on selected tab
//          //  tabBar.selectionIndicatorImage = UIImage()
//        }
//        
        tabBar.unselectedItemTintColor = .black // Your existing tint color
        
        self.delegate = self
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if AppDelegate.shared.tabbarBag == false {
                AppDelegate.shared.tabbarBag = true
                self.addTabbarIndicatorView(index: 3, isFirstTime: true)
                

            } else {
                self.addTabbarIndicatorView(index: 0, isFirstTime: true)
            }

        }
    }
    
    /// Add tabbar item indicator upper line
    func addTabbarIndicatorView(index: Int, isFirstTime: Bool = false) {
        guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else {
            return
        }
        if !isFirstTime {
            upperLineView.removeFromSuperview()
        }
        upperLineView = UIView(frame: CGRect(x: tabView.frame.minX + spacing, y: tabView.frame.minY + 0.1, width: tabView.frame.size.width - spacing * 2, height: 0.3))
        upperLineView.backgroundColor = UIColor.black
        tabBar.addSubview(upperLineView)
    }
    
    // Intercept tab selection
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        if let index = viewControllers?.firstIndex(of: viewController), index == 0 {
            NotificationCenter.default.post(name: NSNotification.Name("ReloadDashboard"), object: nil)
        }
        
        if let index = viewControllers?.firstIndex(of: viewController), index == 4 {
            if THUserDefaultValue.isUserLoging == false {
                let halfVC = LoginVC()
                halfVC.modalPresentationStyle = .overFullScreen
                selectedViewController?.present(halfVC, animated: true)
                return false // prevent tab switch
            }
        }
        
        if let index = viewControllers?.firstIndex(of: viewController), index == 3 {
            AppDelegate.shared.tabbarFlag = true
        }
        
        if let index = viewControllers?.firstIndex(of: viewController), index == 1 {
            print("niyin")
            AppDelegate.shared.tabbarSearch = true

        }
        
        
        return true
    }
}

extension LMTabBarVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        addTabbarIndicatorView(index: self.selectedIndex)
    }
}
