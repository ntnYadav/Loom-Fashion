//
//  CustomNavigation.swift
//  SafeTalk
//
//  Created by SafeTalk on 24/06/22.
//

import Foundation
import UIKit
extension UIViewController{

    // MARK:- NavigationController
        /**
         @discussion -  This function is used for naigation from one ViewController to another
         @paramters -  paramerter is naviagtionTo disired View Contoller,navigationFrom self,naviagtionSting
         @return - NA
         */
    func NavigationController(navigateFrom: UIViewController?,navigateTo: UIViewController?,navigateToString: String?) {
        guard let navigateTo = navigateTo,let navigateFrom = navigateFrom,let navigateToString = navigateToString else {
            return
        }
        let Vc = navigateFrom.storyboard?.instantiateViewController(withIdentifier: navigateToString)
        navigateFrom.navigationController?.pushViewController(Vc!, animated: true)
    }
}

