//
//  RetailShopViewController.swift
//  TouringHealth
//
//  Created by chetu on 27/10/22.
//

import UIKit
import SafariServices
import WebKit

class LMPrivacyPolicyVC: UIViewController,UITextViewDelegate {
    
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var lblPrivacy: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var openURL = ""
    var isFrom :isFromScreen = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        
        txtView.delegate = self
        txtView.isSelectable = true
        txtView.isEditable = false
        txtView.dataDetectorTypes = [.link] // auto-detect links from NSAttributedString
        txtView.linkTextAttributes = [
            .foregroundColor: UIColor.systemBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        if isFrom == .privacyPolicy {
            lblPrivacy.text = "Privacy Policy"
            let htmlString = """
                   <!DOCTYPE html>
                   <html>
                   <head>
                   <style>
                   body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif; font-size: 16px; color: #333; }
                   h1, h2, h2 { color: #222; }
                   ul { margin-left: 20px; }
                   a { color: #007AFF; text-decoration: none; }
                   a:hover { text-decoration: underline; }
                   </style>
                   </head>
                   <body>
                   
                   <p>Welcome to <strong>Loom Fashion Industry</strong>. Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you visit our website <strong>loomfashion.co.in</strong> or shop with us.</p>
                   
                   <h2>Information We Collect</h2>
                   <p>When you use our services or shop on our website, we may collect the following information:</p>
                   
                   <h2>Personal Information</h2>
                   <p>Name, email address, phone number, billing and shipping address, and payment details.</p>
                   
                   <h2>Order Information</h2>
                   <p>Products purchased, date and time of purchase, transaction ID, and order history.</p>
                   
                   <h2>Device Information</h2>
                   <p>IP address, browser type, device type, and cookies (used for improving user experience).</p>
                   
                   <h2>Communication Data</h2>
                   <p>Your inquiries, feedback, or interactions with our customer support.</p>
                   
                   <h2>How We Use Your Information</h2>
                   <p>We use the information we collect to:</p>
                   <ul>
                     <li>Process and fulfill your orders.</li>
                     <li>Communicate order status and updates.</li>
                     <li>Send promotional emails, discounts, and new collection alerts (you can opt out anytime).</li>
                     <li>Improve website experience and customer service.</li>
                     <li>Detect and prevent fraud or misuse of our services.</li>
                   </ul>
                   
                   <h2>Sharing Your Information</h2>
                   <p>We respect your privacy and will never sell your personal data.</p>
                   <p>We only share your information with trusted third parties:</p>
                   <ul>
                     <li>Payment gateways (to process your payments securely).</li>
                     <li>Shipping partners (for order delivery updates and fulfillment).</li>
                     <li>Marketing services (if you’ve opted in for newsletters and offers).</li>
                     <li>Legal obligations (if required by law enforcement or court order).</li>
                   </ul>
                   
                   <h2>Data Security</h2>
                   <p>We use industry-standard security measures like SSL encryption, secure payment gateways, and safe data storage practices to protect your personal information from unauthorized access, misuse, or disclosure.</p>
                   
                   <h2>Your Rights</h2>
                   <p>You have the right to:</p>
                   <ul>
                     <li>Access the personal information we hold about you.</li>
                     <li>Request correction of inaccurate or incomplete data.</li>
                     <li>Request deletion of your data (subject to legal and business requirements).</li>
                     <li>Opt-out of marketing communications at any time.</li>
                   </ul>
                   
                   <h2>Cookies</h2>
                   <p>We use cookies to enhance your browsing experience, understand user behavior, and deliver personalized content. You can control cookie preferences through your browser settings.</p>
                   
                   <h2>Changes to This Policy</h2>
                   <p>We may update this Privacy Policy occasionally to reflect changes in our practices or legal obligations. The updated version will always be posted on this page.</p>
                   
                   <h2>Contact Us</h2>
                   <p>For any questions or concerns about this Privacy Policy, please contact:</p>
                   
                   <p>
                     <strong>Loom Fashion Industry</strong><br />
                     Email: <a href="mailto:loomfashionindustry@gmail.com">loomfashionindustry@gmail.com</a><br />
                     Phone: <a href="tel:+918448833835">8448833835</a><br />
                     Website: <a href="https://loomfashion.co.in" target="_blank" rel="noopener noreferrer">loomfashion.co.in</a>
                   </p>
                   </body>
                   </html>
                   """
            
            // Convert HTML to NSAttributedString
            if let data = htmlString.data(using: .utf8) {
                do {
                    let attrStr = try NSAttributedString(
                        data: data,
                        options: [
                            .documentType: NSAttributedString.DocumentType.html,
                            .characterEncoding: String.Encoding.utf8.rawValue
                        ],
                        documentAttributes: nil)
                    txtView.attributedText = attrStr
                } catch {
                    print("Error parsing HTML: \(error)")
                    txtView.text = "Failed to load privacy policy."
                }
            }
        
        
        
        
        //  webView.load(URLRequest(url: URL(string: "https://www.loomfashion.co.in/policies/privacy-policy")!))
    } else {
        lblPrivacy.text = "Return Policy"
        
        
        let returnPolicyHTML = """
        <!DOCTYPE html>
        <html>
        <head>
        <style>
        body { font-family: -apple-system; font-size: 16px; color: #333; }
        p { margin-bottom: 12px; }
        </style>
        </head>
        <body>

        <p>1. Hassle-free returns within 7 days under specific product and promotion conditions.</p>
        <p>2. Refunds for prepaid orders revert to the original payment method, while COD orders receive a wallet refund.</p>
        <p>3. Report defective, incorrect, or damaged items within 24 hours of delivery.</p>
        <p>4. Products bought during special promotions like BOGO are not eligible for returns.</p>
        <p>5. For excessive returns, reverse shipment fee up to ₹100 can be charged, which will be deducted from the refund.</p>
        <p>6. Non-returnable items include accessories, sunglasses, perfumes, masks, and innerwear due to hygiene concerns.</p>

        </body>
        </html>
        """
        // Convert HTML to NSAttributedString
        if let data = returnPolicyHTML.data(using: .utf8) {
            do {
                let attrStr = try NSAttributedString(
                    data: data,
                    options: [
                        .documentType: NSAttributedString.DocumentType.html,
                        .characterEncoding: String.Encoding.utf8.rawValue
                    ],
                    documentAttributes: nil)
                txtView.attributedText = attrStr
            } catch {
                print("Error parsing HTML: \(error)")
                txtView.text = "Failed to load privacy policy."
            }
        }
    
        
        
        
      //  webView.load(URLRequest(url: URL(string: "https://www.loomfashion.co.in/policies/refund-policy")!))
    }
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
//            switch isFrom {
//            case .fromDiagnosisDetails:
//                viewModel.openUrl(url: openURL)
//            case .fromPrivacyPolicy:
//                webView.load(URLRequest(url: URL(string: "https://uat.thwwwsuccess.com/uploads/privacy-policy.pdf")!))
//            case .termAndConditions:
//                webView.load(URLRequest(url: URL(string: "https://touringhealth.com/wp-content/uploads/2023/04/HIPPA-2023-1.pdf")!))
//            case.openSourceInfo1:
//                webView.load(URLRequest(url: URL(string: openURL)!))
//            case.healthCare101:
//                webView.load(URLRequest(url: URL(string: openURL)!))
//            case.registration:
//                webView.load(URLRequest(url: URL(string: openURL)!))
//            case.logIn:
//                webView.load(URLRequest(url: URL(string: openURL)!))
//            default:
//                viewModel.getURLfromAPI()
//            }
//        guard self.checkInternet else{
//            return
//        }
//        webView.navigationDelegate = self



    
    
    //MARK: action handler
    @IBAction func backActionAction(_ sender: UIButton) {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        self.navigationController?.popViewController(animated: true)
       
    }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL,
                  in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false // prevent default behavior if you want custom
    }

}


//MARK: webview delegate
extension LMPrivacyPolicyVC: WKNavigationDelegate{
  func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
      debugPrint(#function)
  }

  func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
      activityIndicator.startAnimating()
      activityIndicator.isHidden = false
      debugPrint(#function)
  }

  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      activityIndicator.stopAnimating()
      activityIndicator.isHidden = true
      debugPrint(#function)
  }

  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      debugPrint(#function)
  }

  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
      activityIndicator.stopAnimating()
      activityIndicator.isHidden = true
      debugPrint(#function)
  }

  func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
      //SwiftLoader.show(title: keyName.loading, animated: true)
      debugPrint(#function)
  }

  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
      debugPrint(#function)
  }

  func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
      debugPrint(#function)
      //SwiftLoader.hide()
      activityIndicator.startAnimating()
      activityIndicator.isHidden = false
     // SwiftLoader.show(title: keyName.loading, animated: true)
      completionHandler(.performDefaultHandling,nil)
  }

  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
      debugPrint(#function)
      decisionHandler(.allow)
  }

  func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
      debugPrint(#function)
      decisionHandler(.allow)
  }
}
