//
//  HealthCareMedicineViewController.swift
//  TouringHealth
//
//  Created by chetu on 03/03/23.
//

import UIKit

class LMSettingVC: UIViewController {
    
    lazy fileprivate var viewmodel = LMSettingMV(hostController: self)
    @IBOutlet weak var bthYes: UIButton!
    @IBOutlet weak var lblLine: UILabel!
    @IBOutlet weak var viewAlert: UIView!
    @IBOutlet weak var tblSetting: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAlert.isHidden = true
        bthYes.layer.borderWidth = 1
        bthYes.layer.borderColor = UIColor.black.cgColor
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeLeft.direction = .left

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeRight.direction = .right

        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
    }
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
            switch gesture.direction {
            case .left:
                break
            case .right:
                self.navigationController?.popViewController(animated: true)
            default:
                break
            }
        }
    
    @IBAction func actYes(_ sender: Any) {
    }
    @IBAction func actNo(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension LMSettingVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return THconstant.arrSetting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblSetting.dequeueReusableCell(withIdentifier: "LMSettingCell", for: indexPath) as! LMSettingCell
        cell.selectionStyle = .none
        self.tblSetting.separatorColor = .clear
        cell.lblSetting.text = THconstant.arrSetting[indexPath.row]
        cell.lblSetting.font = UIFont(name: "HeroNew-Regular", size: 18)

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            guard let controller = storyboardHome.instantiateViewController(identifier: controllerName.pivacypolicy.controllerID) as? LMPrivacyPolicyVC else {
                debugPrint("ViewController not found")
                return
            }
            controller.isFrom =  .returnpolicy
            self.navigationController?.pushViewController(controller, animated: true)
           // self.NavigationController(navigateFrom: self, navigateTo: LMPrivacyPolicyVC(), navigateToString: VcIdentifier.LMPrivacyPolicyVC)
        } else if indexPath.row == 1 {
            guard let controller = storyboardHome.instantiateViewController(identifier: controllerName.pivacypolicy.controllerID) as? LMPrivacyPolicyVC else {
                debugPrint("ViewController not found")
                return
            }
            controller.isFrom = .privacyPolicy
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 2 {
            
            
            
            let logoutSheet = LogoutBottomSheetVC()
            logoutSheet.modalPresentationStyle = .overCurrentContext
            logoutSheet.modalTransitionStyle = .coverVertical
            logoutSheet.onYesTapped = {
                UserDefaults.standard.set(nil, forKey: "accessToken")
                THUserDefaultValue.userFirstName = nil
                THUserDefaultValue.phoneNumber   = nil
                THUserDefaultValue.userEmail     = nil
                THUserDefaultValue.isUserLoging  = false
                THUserDefaultValue.phoneNumber   = nil
                THUserDefaultValue.userpincodeSecond = nil
                THUserDefaultValue.isUserPincode = nil
                THUserDefaultValue.authTokenTemp = nil

                self.NavigationController(navigateFrom: self, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)

            }
            logoutSheet.onNoTapped = {
                print("User cancelled logout")
            }
            present(logoutSheet, animated: true, completion: nil)
            
            
        } else if indexPath.row == 3 {

            
            let deleteSheet = DeleteAccountBottomSheetVC()
            deleteSheet.modalPresentationStyle = .overFullScreen
            deleteSheet.modalTransitionStyle = .coverVertical
            deleteSheet.onDeleteTapped = {
                print("User confirmed delete")
                self.viewmodel.validateDetailValue()

            }
            deleteSheet.onKeepTapped = {
                print("User kept account")
            }
            present(deleteSheet, animated: true)

        } else if indexPath.row == 4 {

            let deleteSheet = DeleteAccountBottomSheetVC()
            deleteSheet.modalPresentationStyle = .overFullScreen
            deleteSheet.modalTransitionStyle = .coverVertical
            deleteSheet.onDeleteTapped = {
                print("User confirmed delete")
            }
            deleteSheet.onKeepTapped = {
                print("User kept account")
            }
            present(deleteSheet, animated: true)
            
//            let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "LMAlertVC") as! LMAlertVC
//            let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
//            self.present(navController, animated:true, completion: nil)
//            let vc = LMAlertVC()
//            vc.modalPresentationStyle = .overCurrentContext
//            // keep false
//            // modal animation will be handled in VC itself
//            self.present(vc, animated: false)
            
//            viewAlert.isHidden = false
//            UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveLinear, animations: {
//                  let height:CGFloat = 280;
//                  self.viewAlert.frame = CGRect(x: 0, y: self.viewAlert.frame.minY - height, width: self.viewAlert.frame.width, height: self.viewAlert.frame.height)
//              }) { finished in
//                  // animation done
//              }
            //alertDemo.show()

//            UIView.animate(withDuration: 0.3, animations: {
//                self.viewAlert.isHidden = false
//                }) { (finished) in
//                }
        }
    }
    
    

}
