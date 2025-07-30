//
//  extenstionResource.swift
//  TouringHealth
//
//  Created by chetu on 05/10/22.
//

import Foundation
import UIKit
//import Toast_Swift
import SystemConfiguration
import Toast_Swift

extension UIView {
    public func addViewBorder(borderColor:CGColor,borderWith:CGFloat,borderCornerRadius:CGFloat){
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = borderCornerRadius

    }
    func addBottomBorderWithShadow(borderColor: UIColor = .clear, borderHeight: CGFloat = 1.0, shadowColor: UIColor = .black, shadowOpacity: Float = 0.1, shadowRadius: CGFloat = 4.0) {
        
        // Create the bottom border
        let border = UIView()
        border.backgroundColor = borderColor
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        
        NSLayoutConstraint.activate([
            border.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            border.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            border.heightAnchor.constraint(equalToConstant: borderHeight)
        ])
        
        // Add shadow to the view
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

extension UIViewController{
    
    //MARK: internet connection
    
    func showALert(withTitle title: String, message : String) {
        let alert = UIAlertController(title: title , message: message,         preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK",
                                          style: UIAlertAction.Style.cancel,
                                          handler: {(_: UIAlertAction!) in
                                            //Sign out action
            }))
            self.present(alert, animated: true, completion: nil)
        }
//    func showLoader() {
//        DispatchQueue.main.async {
//            let hud =  MBProgressHUD.showAdded(to: self.view, animated: true)
//            hud.mode = .indeterminate
//             hud.label.text = "Loading"
//             hud.isUserInteractionEnabled = true
//             hud.backgroundColor = UIColor(red: 94/255, green:94/255, blue: 94/255, alpha: 0.5)
//        }
//    }
//    func hideLoader() {
//        DispatchQueue.main.async{
//                   MBProgressHUD.hide(for: self.view, animated: true)
//               }
//    }
    
    var checkInternet:Bool{
        
        if isInternetAvailable{
            return true
        }else{
           // self.showToastView(message: keyName.internetError)
            return false
        }
    }
    var isInternetAvailable:Bool{
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    
    //MARK: Toast
    /// Custom Toast view with a message, which dismiss automatically
    /// - Parameters:
    ///   - title: Text to show in title of alert view
    ///   - message: Text message you want to show inside the alert box
    func showToastView( message: String, style: ToastStyle? = nil, position: ToastPosition? = nil, time: TimeInterval? = nil) {
        if let toastStyle = style {
            self.view.makeToast(message, duration: 2.0, position: .top, style: toastStyle)
        } else {
            self.view.makeToast(message, duration: time ?? 2.0, position: position ?? .top)
        }
    }
    func showNewToastView( message: String, style: ToastStyle? = nil, position: ToastPosition? = nil, time: TimeInterval? = nil) {
        if let toastStyle = style {
            self.view.makeToast(message, duration: 0.5, position: .center, style: toastStyle)
        } else {
            self.view.makeToast(message, duration: time ?? 0.5, position: position ?? .center)
        }
    }
    func showToastCenter(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    func bottomToast(){
        let messageVC = UIAlertController(title: "Message Title", message: "Account Created successfully" , preferredStyle: .actionSheet)
        present(messageVC, animated: true) {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                messageVC.dismiss(animated: true, completion: nil)})}
    }
    
    
    func logoutAlert(){
        let refreshAlert = UIAlertController(title: "Logout", message: "Are you sure want to logout?", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            // self.logOutApiCall()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            debugPrint("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    
    //MARK: call logout API
//    func logOutApiCall(complition:@escaping(_ isLogout:Bool)-> Void){
//        THApiHandler.getApi(responseType: LogoutResponseModel.self) { [weak self] dataResponse, error in
//            debugPrint(dataResponse as Any)
//            THUserDefaultValue.fromLogout = true
//            THUserDefaultValue.isUserLoging = false
//            THUserDefaultValue.authToken = nil
//            complition(true)
//            
//        }
//    }
//    
    
    
}


extension String {
    func isValidEmail() -> Bool {
//        "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3,64}", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidPassword() -> Bool {
        let password = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        return  password.evaluate(with: self)
    }
    
    func trimPhoneNumber() -> String {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        //        return trimmed
        let okayChars = Set("1234567890")
        return trimmed.filter {okayChars.contains($0) }
    }
    
//    let inputFormatter = NSDateFormatter()
//    inputFormatter.dateFormat = "MM/dd/yyyy"
//    let showDate = inputFormatter.dateFromString("07/21/2016")
//    inputFormatter.dateFormat = "yyyy-MM-dd"
//    let resultString = inputFormatter.stringFromDate(showDate!)
//    print(resultString)
    func convertUTCToLocalDateString(timeStamp:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: timeStamp)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let resultString = dateFormatter.string(from: date!)
        return resultString
    }
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            return outputFormatter.string(from: date)
        }
        return nil
    }
    
    func convertToStandardDate(from input: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "MMM-dd-yyyy"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"

        if let date = inputFormatter.date(from: input) {
            return outputFormatter.string(from: date)
        } else {
            return nil
        }
    }
    var firstWordCapitalized: String {
            guard let first = self.first else { return self }
            return first.uppercased() + self.dropFirst()
        }
}
/// use for get controller name
enum controllerName : String {
    case pivacypolicy
    
    var controllerID : String {
        switch self {
        case .pivacypolicy : return "LMPrivacyPolicyVC"
        }
    }
}

extension UIButton {
    func loadingIndicator(_ show: Bool) {
        let tag = 808404
        if show {
            self.isEnabled = false
            self.alpha = 0.5
            let indicator = UIActivityIndicatorView()
            indicator.style = UIActivityIndicatorView.Style.large
            indicator.color = .black
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.isEnabled = true
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}



extension UILabel {
    
    @IBInspectable var fontSizeKey: String? {
        get {
            return self.font.fontName
        }
        set {
            let valueArr = newValue?.split(separator: "-")
            if valueArr?.count == 2 {
                self.font = UIFont(name: THconstant.APP_FONT + "-" + (valueArr?[1] ?? ""), size: textX(String(valueArr?[0] ?? "17.0")))
            }
            else {
                self.font = UIFont(name: self.font.fontName, size: textX(newValue ?? "17.0"))
            }
        }
    }
    
    func colorString(text: String?, coloredText: String?, color: UIColor?) {
        
        let attributedString = NSMutableAttributedString(string: text!)
        let range = (text! as NSString).range(of: coloredText!)
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color!],
                                       range: range)
        self.attributedText = attributedString
    }
}

extension UIViewController{

    // Global Alert
    // Define Your number of buttons, styles and completion
    public func openAlert(title: String,
                          message: String,
                          alertStyle:UIAlertController.Style,
                          actionTitles:[String],
                          actionStyles:[UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)]){

        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
}

extension String {

    func stripOutHtml() -> String? {
        do {
            guard let data = self.data(using: .unicode) else {
                return nil
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return nil
        }
    }
    
    
}


class AlertManager {
    
    static func showAlert(on viewController: UIViewController,
                          title: String,
                          message: String,
                          okTitle: String = "OK",
                          completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okTitle, style: .default) { _ in
            completion?()
        }
        
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}

struct AppFont {
    static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "Hero New Regular", size: size)!
    }

    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "Hero New Bold", size: size)!
    }
    
    static func Medium(size: CGFloat) -> UIFont {
        return UIFont(name: "Hero New Medium", size: size)!
    }
    
    static func semobold(size: CGFloat) -> UIFont {
        return UIFont(name: "Hero New SemiBold", size: size)!
    }
    
    static func light(size: CGFloat) -> UIFont {
        return UIFont(name: "Hero New Light", size: size)!
    }
    
    static func thin(size: CGFloat) -> UIFont {
        return UIFont(name: "Hero New Thin", size: size)!
    }
}

class BorderedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 0
        self.clipsToBounds = true
      
    }
}
