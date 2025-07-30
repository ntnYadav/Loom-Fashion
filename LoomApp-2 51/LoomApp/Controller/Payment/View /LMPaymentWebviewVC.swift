//
//  RetailShopViewController.swift
//  TouringHealth
//
//  Created by chetu on 27/10/22.
//

import UIKit
import SafariServices
import WebKit

class LMPaymentWebviewVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var lblPrivacy: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var openURL = ""
    var isFrom :isFromScreen = .none

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        
        

            webView.load(URLRequest(url: URL(string: openURL)!))

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
        guard self.checkInternet else{
            return
        }
        webView.navigationDelegate = self



    }
    
    //MARK: action handler
    @IBAction func backActionAction(_ sender: UIButton) {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        self.navigationController?.popViewController(animated: true)
       
    }
   

}


//MARK: webview delegate
extension LMPaymentWebviewVC {
  func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
      debugPrint(#function)
  }

  func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
      //activityIndicator.startAnimating()
      //activityIndicator.isHidden = false
      debugPrint(#function)
  }

  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      //activityIndicator.stopAnimating()
      //activityIndicator.isHidden = true
      debugPrint(#function)
  }

  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      debugPrint(#function)
  }

  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
      //activityIndicator.stopAnimating()
      //activityIndicator.isHidden = true
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
      //activityIndicator.startAnimating()
      //activityIndicator.isHidden = false
     // SwiftLoader.show(title: keyName.loading, animated: true)
      completionHandler(.performDefaultHandling,nil)
  }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let urlString = navigationAction.request.url?.absoluteString ?? ""
        debugPrint("🔗 Navigating to: \(urlString)")

        if urlString.contains("razorpay_payment_link_status=paid") || urlString.contains("payment/success") {
            handlePaymentSuccess()
        } else if urlString.contains("razorpay_payment_link_status=failed") || urlString.contains("payment/failure") {
            handlePaymentFailure()
        }
        
        decisionHandler(.allow)
    }
    func handlePaymentFailure() {
        // Stop any loader
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        
        // Show an alert to user
        let alert = UIAlertController(title: "Payment Failed", message: "Something went wrong with your payment. Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            // Optional: go back or dismiss view controller
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
        // Optionally log or notify your analytics system
        debugPrint("❌ Payment failed")
    }

    func handlePaymentSuccess() {
        // Example:
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        
        // Show confirmation UI or dismiss
       // showAlert(title: "Success", message: "Your payment was successful!")

        // Or notify backend / update app state
    }

  func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
      debugPrint(#function)
      decisionHandler(.allow)
  }
}
