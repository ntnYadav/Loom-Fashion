
//  Created by Loom App on 01/04/25.
import Foundation
import UIKit

//TestB@9627
struct THconstant {
    //Final relase to App store Link
//    static let baseURL = Domains.UATproductionserver.rawValue
    
//     static let baseURL = Domains.devlopmentServer.rawValue
    
    static let baseURL = Domains.devlopmentServer.rawValue

//    static let baseURL = Domains.QAserver.rawValue
  
    
    static var Temp = "Accept"
    static  let titleSegmentTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    static let headerContentTypeName = "Accept"
    static let headerContentTypeValue = "application/json"
  
//    static var storyboardMain :UIStoryboard {
//        return StoryboardsRefrence.storyboardType.main_storyboard
//    }
//    
//    static var storyboardHome :UIStoryboard {
//        return StoryboardsRefrence.storyboardType.home_storyboard
//    }
    //https://product-api.loomfashion.co.in/health
    static let baseurlTemp           = "https://product-api.loomfashion.co.in/product/admin/"
    
    static let cancel                 = "Cancel"
    static let selectDate             = "Select Date"
    static let selectAnniversaryDate  = "Select anniversary date"
    static let selectDOBDate          = "Select Date of birth"
    static let selectGender           = "Select gender"
    static let dateFormate            = "YYYY-MM-dd"
    static let dateCalender           = "YYYY-MM-dd"
    static let done                   = "Done"
    static let countryCode            = "+91"
    
    
   
    static let femaleBackTopArray = ["Head","Shoulder","Neck"]
    static let femaleBackMiddleArray = ["Back","Triceps","Wrist","Loin","Sacrum","Gluteus","Hamstring"]
    static let femaleBackBottomArray = ["Hamstring","Calf","Heel of foot","Sole"]
    
    static let arrGender  = ["Male", "Female", "Other"]
    static let arrqty     = ["1", "2", "3","4","5"]
    static let arrSetting = ["Return And Exchange Policy", "Privalicy Policy", "Logout", "Delete Account"]
    static let arrListDelete = ["Changed my mind", "Ordered by mistake", "Found a better price elsewhere","Delivery is too late","Ordered wrong item","Other"]

    
    static let  arrProfile = ["PROFILE", "ORDERS", "WISHLIST", "ADDRESS", "WALLET", "RATE & REVIEW" ,"SETTINGS"]
  //  static let  arrProfile = ["PROFILE", "ORDERS", "WISHLIST", "ADDRESS","CREATE AND EARN", "REFUNDS","RATE AND REVIEW","SETTINGS"]

    static let itemsColor: [Item] = [Item(title: "GRAY"),Item(title: "BLACK"),Item(title: "NAVY"),Item(title: "BEIGE"),Item(title: "BROWN"),Item(title: "CREAM"),Item(title: "GREEN"),Item(title: "OLIVE"),Item(title: "BLUE"),Item(title: "WHITE")]
    
    
    static let APP_FONT: String = "HeroNew-Regular"
    
    static private let adjustFactorWithConsiderationOfIpad = UIScreen.main.traitCollection.userInterfaceIdiom == .pad ? 0.65 : 1.0
    
    static let scaleFactorWidth: CGFloat = (UIScreen.main.bounds.width / 375.0) * CGFloat(adjustFactorWithConsiderationOfIpad)
    
    static let size = ["default"                  : CGFloat(15),
                       "max"                      : CGFloat(72),
                       "extraLargePlus"           : CGFloat(30),
                       "extraLarge"               : CGFloat(22),
                       "large"                    : CGFloat(20),
                       "medium"                   : CGFloat(15),
                       "small"                    : CGFloat(13),
                       "extraSmall"               : CGFloat(10),
                       "superSmall"               : CGFloat(8)
                       ]
}
enum StoryboardsRefrence {
    case storyboardType
    var main_storyboard:UIStoryboard {
        switch UIDevice.current.userInterfaceIdiom {
        default:
            return   UIStoryboard(name: "Main", bundle: Bundle.main)
        }
    }
}
var storyboardHome :UIStoryboard {
    return StoryboardsRefrence.storyboardType.main_storyboard
}
// IdentifyFrom which screen
enum isFromScreen {
    case LMSettingVC
    case privacyPolicy
    case returnpolicy
    case fromRegisterScreen
    case fromDiagnosisDetails
    case none
    case fromPrivacyPolicy
    case termAndConditions
    case openSourceInfo1
    case healthCare101
    case registration
    case logIn
}
public func logd(v: Any..., separator: String = " ", terminator: String = "\n") {
    let output = v.map { "\($0)"}.joined(separator: separator)
    Swift.print(output, terminator:  terminator)
}
enum btnState {
    static let btnSignup = "Sign Up"
    static let btnSignIn = "Sign In"}

enum Authentication {
    static let username = "safetalkhost"
    static let password = "safetalkhost@123"
}
enum StringConstant {
    static let username = "Username"
    static let password = "Password"
    static let Phone = "Phone Number"
}

enum VcIdentifier {
    static let authVc            = "AuthVc"
    static let viewController    = "ViewController"
    static let LoginVC           = "LoginVC"
    static let LMHomeScreenVC    = "LMHomeScreenVC"
    static let LMTabBarVC        = "LMTabBarVC"
    static let LMPlayVC          = "LMPlayVC"
    static let LMProductDetailVC = "LMProductDetailVC"
    static let LMFilterVC                  = "LMFilterVC"
    static let LMProductAllDetailVC        = "LMProductAllDetailVC"
    static let LMDashboardVC               = "LMDashboardVC"
    static let VerifyVC                    = "VerifyVC"
    static let LMWishlistVC                = "LMWishlistVC"
    static let LMOrderlistVC               = "LMOrderlistVC"
    static let LMProfileVC                 = "LMProfileVC"
    static let LMAddressVC                 = "LMAddressVC"
    static let LMAddressAddVC              = "LMAddressAddVC"    
    static let LMAddresslistVC             = "LMAddresslistVC"
    static let LMSettingVC                 = "LMSettingVC"
    static let LMPrivacyPolicyVC           = "LMPrivacyPolicyVC"
    static let LMSearchVC                  = "LMSearchVC"
    static let LMShopTempVC                = "LMShopTempVC"
    static let LMShopNow                   = "LMShopNow"
    static let LMContactDetailsVC          = "LMContactDetailsVC"
    static let LMPRoductDetailFinalVC1     = "LMPRoductDetailFinalVC1"
    static let LMProductDetVC              = "LMProductDetVC"
    static let LMOrderDetaillistVC         = "LMOrderDetaillistVC"
    static let LMOrderStatusVC             = "LMOrderStatusVC"
    static let LMCartTableVC               = "LMCartTableVC"
    static let LMAddressAddVC1             = "LMAddressAddVC1"
    static let LMReviewRateVC              = "LMReviewRateVC"
    static let LMDashboardHomeVC           = "LMDashboardHomeVC"
    static let LMReviewRateVC1             = "LMReviewRateVC1"
    static let LMReviewRateListVC          = "LMReviewRateListVC"
    static let LMPaymentWebviewVC             = "LMPaymentWebviewVC"
    static let LMPaymentFinalVC             = "LMPaymentFinalVC"
    static let LMWalletVC             = "LMWalletVC"
    static let returnOrderVC             = "returnOrderVC"
    static let LMChartVC             = "LMChartVC"

    
    
   // self.NavigationController(navigateFrom: self, navigateTo: LMSearchVC(), navigateToString: VcIdentifier.LMSearchVC)

}

enum CellIdentifier {
    static let TabelViewCell       = "TabelViewCell"
    static let playCell            = "Cell"
    static let LMPlaycell          = "LMPlaycell"
    static let LMNew               = "LMNew"
    static let LMLMDefaultCell     = "LMDefaultCell"
    static let LMAddresslistCell   = "LMAddresslistCell"
    static let LMProductHeader     = "LMProductHeader"
    static let DetailHTMLcell      = "DetailHTMLcell"
    static let CustomHeaderView    = "CustomHeaderView"

    
    

    }

enum UserdefaultKey {
    static let name = "Name"
}

enum validateFields {
    static let validName = "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$"
}

enum MessagePassing {
    static let wantstoCommunicate             = "Wants to Communicate"
    static let authenticationForCommunication = "Authentication For Communication"
    static let communicationestablished       = "Communication established"
    static let communicationdenied            = "Communication request denied"
}

enum JasonKey {
    static let String = "String"
}

enum EroorConnecting {
    static let Errorpackagingmessage = "Error packaging message"
    static let Errorsending          = "Error sending"
}

enum ShowAlertMessage {
    static let pleaseEnterOrganisationName = "Please enter organisation name"
    static let pleaseEnterAgentName        = "Please enter agent name"
    static let pleaseEnterDesignationName  = "Please enter designation Name"
    static let youareHeroNow               = "You are Hero Now!"
    static let appName                     = "Safetalk Connect"
    static let cancel                      = "Cancel"
    static let decline                     = "Decline"
    static let organistationNameisEmpty    = "Please enter organisation name"
    static let agentNameisEmpty            = "Please enter agent name"
    static let designationNameisEmpty      = "Please enter designation name"
    static let userNameEmpty               = "Please enter the username"
    static let passwordisEmpty             = "Please enter the password"
    static let userNameisInvalid           = "Please enter the valid username"
    static let passwordisInvalid = "Please enter the valid password"
    static let OrganisationNameslashn = "Organisation Name:-\n"
    static let AgentNameslashn = "Agent Name: -\n"
    static let Designationslashn = "Designation: -\n"
    static let pleaseEnterClientName = "Please enter username"
    static let pleaseEnterPhoneNumber = "Please enter the phone number"
    static let pleaseEnterCorrectClientName = "Please enter the correct username"
    static let pleaseEnterCorrectPhoneNumber = "Phone number must be 10 digits"
    static let pleaseEnterTheEmail = "Please enter the email adddress"
    static let pleaseEnterThePassword = "Please enter the password"
    static let pleaseEnterTheComfirmPassword = "Password and confirm password did't match"
    static let pleaseEnterTheConfirmPassword = "Please enter the confirm Password"
    static let pleaseEnterTheCorrectEmail = "Please enter the correct email"
    static let pleaseEnterTheCorrectPassword = "Password must be more than 8 characters"
    static let pleaseEnterTheCorrectPasswordRegex = "Password must contain one capital, one small, one number and one special character."
    static let pleaseselecttermsandcondition = "Please select terms and condition"
    static let pleaseselecttermsandconditionTran = "Please select terms and condition1"
    static let dataUpdatedSuccesfully = "Data updated succesfully"
    static let selectfrequency = "Select frequency"
    static let dataUpdatedSuccessfulyLoginAgain = "Data updated successfully \n login again"
    static let areyousureyouwantto = "Are you sure you want to"
    static let phonenumberalreadyexists = "Phone number already exists"
    static let pleaseentertherequiredfields = "Please enter the required fields"
    static let weWillContacYouSoon = "We will contact you soon"
    static let areYouSureWantTologout = "Are you sure want to logout?"
    static let alert = "Alert"
    static let ContactSupport = "Contact Support"
    static let messageSendSuccessfully = "Message sent successfully"
    static let standByforIncomingCall = "StandBy for incoming call"
    static let deleteAccountMessage = "Are you sure want to delete this account? Deleting it will result in a permanent removal of your account from the system."
}

enum StateImage {
    static let iNITIATECOMMUNICATION = "INITIATE COMMUNICATION"
}

enum TypeUser {
    static let client = "Client"
    static let Host = "Host"
}

enum NavigationView{
    static let statusBar = "statusBar"
}

enum StoryBoard{
    static let main = "Main"
}

enum ScreeName {
    static let clientScreen = "Client "
    static let HostScreen = "Host"
}

enum DataNotFound {
    static let noUserAvailabel = "No User Available "
    static let waitingForFirstResponder = "WAITING FOR FIRST RESPONDER"
}

enum ServiceKey {
    static let current_latitude = "current_latitude"
    static let current_longitude = "current_longitude"
}

enum EroorCodeMessage {
    static let InvalidPassword = "Invalid Password"
    static let InvalidCreaditials = "Invalid Creaditials"
    static let InvalidEmailId = "Invalid Email Id"
    static let UserNotFound = "User not found"
}

enum userDefaultKeys {
    static let userInfo = "userInfo"
    static let deviceToken = "DeviceToken"
}
let twilioIdentifier = "TwilioCallViewController"

struct keyName {
    
    static let percentage    = "percentage"
    static let emailCheck    = "Please enter your email id"
    static let sessionTitle  = "Your session has expired"
    static let passwordField = "Please enter your password"
    static let state         = "Please enter state"
    static let city          = "Please enter city"
    static let house         = "Please enter house/ flat/ office no"
    static let pincode       = "Please enter pincode"
    static let area          = "Please enter area/ locality/ town"
    static let DOB           = "Please enter date of birth"
    static let Anniversary   = "Please enter Anniversary"
    static let Gender        = "Please enter Gender"
    static let rupessymbol   = "₹"
    
    static let Edit          = "Edit"
    static let validEmail    = "Please enter valid email id"
    static let emptyStr      = ""
    static let sessionMessage = "Please log in again to continue using the app"
    static let ok             = "OK"
    static let backenError    = "Something went wrong"
    static let null           = "null"
    static let validPhoneNumber = "Please enter valid phone number"
    static let phoneNumber      = "Please enter phone number"
    static let name             = "Please enter name"
    static let allowedCharacter = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz  1234567890"
    static let allowedCharacter1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz@."

    static let separator        = "."
    static let otherSave        = "OTHER SAVED ADDRESS"
    static let DefaultAddress   = "Default Address"
    static let phonemsgNumber   = "The phone number format is incorrect"
    static let CANCELLED        = "CANCELLED"
    static let DELIVERED        = "DELIVERED"
    static let apiMultiformHeader = "multipart/form-data"

    static let fileName = "images"

}
public func getPercentage(findVal:Int ,totalVal:Int) -> Int{
    let calculate = (findVal * totalVal) / 100
    return calculate
}
struct ConstantFontSize {
    static let regular   = "HeroNew-Regular"
    static let Medium    = "HeroNew-Medium"
    static let Semibold  = "HeroNew-SemiBold"
    static let Bold      = "HeroNew-Bold"
    static let Light     = "HeroNew-Light"
    static let Thin      = "HeroNew-Thin"
}

//func isFileDocType() -> Bool {
//    switch self {
//    case "pdf":
//        return true
//    case "doc":
//        return true
//    case "docx":
//        return true
//    case "odt":
//        return true
//    case "xls":
//        return true
//    case "xlsx":
//        return true
//    case "ods":
//        return true
//    case "ppt":
//        return true
//    case "pptx":
//        return true
//    case "txt":
//        return true
//    default:
//        return false
//    }
//}

/// colour name use in App
struct ConstantColour {
    static let appColourCode = "#3A2FA9"
    static let appColour : UIColor = UIColor(red: 58.0/255.0, green: 47.0/255.0, blue: 169.0/255.0, alpha: 1.0)
    static let activateButtonColour : UIColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
    static let bordercolor: UIColor = UIColor.init(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)

    static let borderColor1 : UIColor = UIColor(red:121/255.0, green: 121/255.0, blue: 121/255.0, alpha: 0.5)
    
    static let colorDone : UIColor = UIColor(red: 255/255.0, green: 88/255.0, blue: 1/255.0, alpha: 1.0)

    static let Contact : UIColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
    static let deactivateButtonColour : UIColor = .gray
    static let Diagonsis : UIColor = UIColor(red: 219.0/255.0, green: 233.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let Community : UIColor =  UIColor(red: 194.0/255.0, green: 244.0/255.0, blue: 233.0/255.0, alpha: 1.0)
    static let Store : UIColor = UIColor(red: 255.0/255.0, green: 237.0/255.0, blue: 209.0/255.0, alpha: 1.0)
    static let redColour :UIColor = .red
    static let communityColour: UIColor = UIColor.init(red: 69/255, green: 17/255, blue: 201/255, alpha: 1)
}

struct MimeTypes {
    static let pdf = "application/pdf"
    static let image = "image/jpeg"
}
 
struct ParamKeys {
    static let file         = "files"
    static let accept       = "Accept"
    static let filesArray   = "ufile"
}
extension String {

  
    
    func isFileDocType() -> Bool {
        switch self {
        case "pdf":
            return true
        case "doc":
            return true
        case "docx":
            return true
        case "odt":
            return true
        case "xls":
            return true
        case "xlsx":
            return true
        case "ods":
            return true
        case "ppt":
            return true
        case "pptx":
            return true
        case "txt":
            return true
        default:
            return false
        }
    }
}
