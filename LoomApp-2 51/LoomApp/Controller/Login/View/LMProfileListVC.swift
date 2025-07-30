//
//  LoginVc.swift
//  SafeTalk
//
//  Created by SafeTalk on 15/06/22.
//

import UIKit

class LMProfileListVC: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var scrollViewLogin: UIScrollView!
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var btnrefresh: UIButton!
    @IBOutlet weak var tblProfile: UITableView!
    @IBOutlet weak var txtPhoneNo: UITextField!
  //  lazy private var viewmodel = LoginVM(hostController: self)
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var lblSignin: UILabel!
    
    var boolFlag: Bool = true
    var boolFlagTemp: Bool = true


    override func viewDidLoad() {
        super.viewDidLoad()
       
        if AppDelegate.shared.boolTemp == true {
            AppDelegate.shared.boolTemp = false
            viewProfile.isHidden = false
        } else {
            viewProfile.isHidden = false
        }

        btnrefresh.layer.cornerRadius = btnrefresh.layer.frame.width / 2
        txtPhoneNo.delegate = self //set delegate to textfile
        lblSignin.text = "     Sign in with email or phone number"
        guard let name = THUserDefaultValue.userFirstName else {
            return
        }
        self.lblName.text = "Hi " + name
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
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
    
  
    // MARK:- btnBack
        /**
         @discussion - This Action is used when
         @paramters - Button
         @return - NA
         */
    @IBAction func actSigin(_ sender: Any) {
        //GlobalLoader.shared.show()
        view.endEditing(true)
      //  viewmodel.validateValue()

//        let vc = HalfScreenPhoneVerifyVC()
//        vc.modalPresentationStyle = .overFullScreen
//        vc.modalTransitionStyle = .crossDissolve  // Smooth fade animation
//        self.present(vc, animated: true, completion: nil)

        
        
        
    self.NavigationController(navigateFrom: self, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "LMTabBarVC") as? UITabBarController {
            tabBarController.selectedIndex = 2  // Open 3rd tab
            self.navigationController?.pushViewController(tabBarController, animated: true)
        }
       // self.NavigationController(navigateFrom: self, navigateTo: VerifyVC(), navigateToString: VcIdentifier.VerifyVC)

    }
    
    @IBAction func actSignUp(_ sender: Any) {
        
        if boolFlag == true {
            boolFlag = false
            btnSignUp.setTitle("Sign In", for:.normal)
            btnSignIn.setTitle("Sign Up with OTP", for:.normal)
            lblSignin.text = "     Sign Up with email or phone number"
        } else {
            boolFlag = true
            btnSignUp.setTitle("Sign Up", for:.normal)
            btnSignIn.setTitle("Sign in with OTP", for:.normal)
            lblSignin.text = "     Sign In with email or phone number"

        }
    }
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
       // self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Text Field Delegate Method (Phone No)
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if string.isEmpty { return true } // Accepting control characters
           
           let newText = (txtPhoneNo.text! as NSString).replacingCharacters(in: range, with: string)
           
           // Allow numeric input only and restrict to 10 digits
           if newText.count > 10 || !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)) {
               return false
           }
           return true
       }
    
    @IBAction func actRefresh(_ sender: Any) {
        
    }
}

extension LMProfileListVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return THconstant.arrProfile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
        cell.selectedBackgroundView?.backgroundColor = .clear
        cell.selectionStyle = .none  // remove default blue selection
        
//        let selectedView = UIView()
//        selectedView.backgroundColor = UIColor.lightText.withAlphaComponent(0.3)
//        cell.selectedBackgroundView = selectedView

            cell.textLabel?.text = THconstant.arrProfile[indexPath.row]
            cell.textLabel?.font = UIFont(name: "HeroNew-Regular", size: 16)
            cell.textLabel?.textColor = .black
            cell.backgroundColor = .clear
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tblProfile(tableView, cellForRowAt: indexPath)
//        cell.contentView.backgroundColor = UIColor.clear

        if indexPath.row == 0 {
            self.NavigationController(navigateFrom: self, navigateTo: LMProfileVC(), navigateToString: VcIdentifier.LMProfileVC)
        } else if indexPath.row == 1 {
            self.NavigationController(navigateFrom: self, navigateTo: LMOrderlistVC(), navigateToString: VcIdentifier.LMOrderlistVC)
        } else if indexPath.row == 2 {
            self.NavigationController(navigateFrom: self, navigateTo: LMWishlistVC(), navigateToString: VcIdentifier.LMWishlistVC)
        } else if indexPath.row == 3 {
            self.NavigationController(navigateFrom: self, navigateTo: LMAddresslistVC(), navigateToString: VcIdentifier.LMAddresslistVC)
        } else if indexPath.row == 4 {
            self.NavigationController(navigateFrom: self, navigateTo: LMWalletVC(), navigateToString: VcIdentifier.LMWalletVC)
        } else if indexPath.row == 5 {
            //THUserDefaultValue.isUserLoging = true
            self.NavigationController(navigateFrom: self, navigateTo: LMReviewRateVC1(), navigateToString: VcIdentifier.LMReviewRateVC1)
        } else if indexPath.row == 6 {
            self.NavigationController(navigateFrom: self, navigateTo: LMSettingVC(), navigateToString: VcIdentifier.LMSettingVC)

        }
        
        
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

