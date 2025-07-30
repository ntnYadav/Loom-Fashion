//
//  cancelOrderVc.swift
//  cancelOrderSheet
//
//  Created by Abdul Quadir on 13/07/25.
//

import UIKit

class filterProductVC: UIViewController , UITextViewDelegate {

   
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var onApplyTapped: ((String?, String?) -> Void)?
    var onApplyTappedSorting: ((String?, String?) -> Void)?


    @IBOutlet weak var textview: UITextView!
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    
    @IBOutlet weak var btnSorting: UIButton!
    
    @IBOutlet weak var btnClear: UIButton!
    
    var objectNavigation = ""
    var filterKeys: [String] = []

    var selectedIndex: Int? = nil
    let placeholderText = "We care about your experience - let us know why you're canceling."
    var reasonsCancelFilter: [String: String] = [
        "Newest": "newest",
        "Popular": "popular",
        "Price: Low to High": "priceLowToHigh",
        "Price: High to Low": "priceHighToLow",
        "Discount: High to Low": "discountHighToLow"
    ]
    
    var reasonsCancelFilterFinal = [
          "Newest",
          "Popular",
          "Price: Low to High",
          "Price: High to Low",
          "Discount: High to Low"
      ]
    var reasons = [
          "Changed my mind",
          "Ordered by mistake",
          "Found a better price elsewhere",
          "Delivery is too late",
          "Ordered wrong item",
          "Other"
      ]
    
   
    
//    var filterKeys: [String] {
//        return Array(reasonsCancelFilter.keys)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        filterKeys = Array(reasonsCancelFilter.keys)

//        val sortingMap = mapOf<String, String>(
//                        "Newest" to "newest",
//                        "Popular" to "popular",
//                        "Price: Low to High" to "priceLowToHigh",
//                        "Price: High to Low" to "priceHighToLow",
//                        "Discount: High to Low" to "ratingHighToLow",
//                    )
        
    
      
       



 }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if objectNavigation == "True" {
            heightConstraint.constant = 0
            view.layoutIfNeeded()
          //            reasons = [
//                "Newest" to "newest",
//                "Popular" to "popular",
//                "Price: Low to High" to "priceLowToHigh",
//                "Price: High to Low" to "priceHighToLow",
//                "Discount: High to Low" to "ratingHighToLow",
//              ]
            tableview.isHidden = false
            textview.isHidden = true
            
            btnClear.setTitle("Clear", for: .normal)
            btnSorting.setTitle("Sort By", for: .normal)

           
        }else{
            tableview.isHidden = false

            textview.isHidden = true
            view.endEditing(true)
            configureTextViewAsPlaceholder()
            textview.delegate = self
               textview.isHidden = true
               configureTextViewAsPlaceholder()
               addDoneButtonOnKeyboard()

               tableview.separatorStyle = .none
               tableview.estimatedRowHeight = 44
               tableview.rowHeight = UITableView.automaticDimension
               tableview.alwaysBounceVertical = true

               NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
               NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeLeft.direction = .left

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeRight.direction = .right

        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
        
        
    }

//2ad
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
    
    @objc private func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.transform = .identity
        }
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        // Only shift up if view hasn't already moved
        if self.view.transform == .identity {
            UIView.animate(withDuration: 0.3) {
                self.view.transform = CGAffineTransform(translationX: 0, y: -(keyboardFrame.height + 240) / 2)
            }
        }
    }

    //
    @objc func doneButtonTapped() {
        textview.resignFirstResponder() //  Dismiss keyboard
    }

    
//    @objc func keyboardWillShow(notification: Notification) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            self.tableview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
//        }
//    }

//    @objc func keyboardWillHide(notification: Notification) {
////        doneBtn.isHidden = true
//    }
    deinit {
           NotificationCenter.default.removeObserver(self)
       }
    func textViewDidChange(_ textView: UITextView) {
        let trimmed = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
//        doneBtn.isHidden = trimmed.isEmpty
    }
    
    private func configureTextViewAsPlaceholder() {
            textview.text = placeholderText
            textview.textColor = .lightGray
            textview.layer.borderColor = UIColor.lightGray.cgColor
            textview.layer.borderWidth = 1.0
            textview.layer.cornerRadius = 8.0
        }
    func textViewDidBeginEditing(_ textView: UITextView) {
          if textView.text == placeholderText {
              textView.text = ""
              textView.textColor = .black
          }
      }
    func textViewDidEndEditing(_ textView: UITextView) {
           if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
               configureTextViewAsPlaceholder()
           }
//        doneBtn.isHidden = true
       }
    
    @IBAction func doneBtnTaped(_ sender: Any) {
        textview.resignFirstResponder()
        doneBtn.isHidden = true
    }
    
    func addDoneButtonOnKeyboard() {
          let toolbar = UIToolbar()
          toolbar.sizeToFit()

          let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
          let done = UIBarButtonItem(title: "DONE", style: .done, target: self, action: #selector(doneButtonTapped))
          done.tintColor = .systemBlue

          toolbar.items = [flexSpace, done]
          textview.inputAccessoryView = toolbar
        
        
      }

    @IBAction func actOrderCancel(_ sender: Any) {
        guard let button = sender as? UIButton else { return }

        if objectNavigation == "True" {
            if let index = selectedIndex {
                 let key = filterKeys[index]
                 let value = reasonsCancelFilter[key] ?? ""
                 self.onApplyTappedSorting?(value, "Clear")
                 self.dismiss(animated: true)
             } else {
                 // No selection — show alert
                 let alert = UIAlertController(title: "", message: "Please select sorting option", preferredStyle: .alert)
                 alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                 self.present(alert, animated: true, completion: nil)
             }
        }else{
            if textview.text != "" {
                    self.onApplyTapped?(textview.text, "")
                } else {
                    let ob = reasons[selectedIndex ?? 0]
                    self.onApplyTapped?(ob, "")
                }
                self.dismiss(animated: true)

            }
    }
    
    @IBAction func actCancelReason(_ sender: Any) {
        if objectNavigation == "True"{
           // do  nothing actionable
        }else{
            self.dismiss(animated: true)
        }
        
    }
    
    
}


extension filterProductVC: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if objectNavigation == "True" {
            return reasonsCancelFilterFinal.count

        } else {
            return reasons.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if objectNavigation == "True" {
            let obj = reasonsCancelFilterFinal[indexPath.row]
            cell.textLabel?.text = obj
        } else {
            let obj = reasons[indexPath.row]
            cell.textLabel?.text = reasons[indexPath.row]
        }
     
        cell.textLabel?.textAlignment = .center
        cell.selectionStyle = .none

        if indexPath.row == selectedIndex {
              cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
          } else {
              cell.backgroundColor = .clear
          }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedIndex = indexPath.row
        
            
        if objectNavigation == "True" {
            
            let keyFinal = reasonsCancelFilterFinal[indexPath.row]                     // e.g. "Popular"

            let key = filterKeys[indexPath.row]
            
            if let value = reasonsCancelFilter[keyFinal] {
                print("Value for key '\(key)' is: \(value)")
                self.onApplyTappedSorting!(value, "")
                self.dismiss(animated: true)
            } else {
                print("Key '\(key)' not found in dictionary")
            }
            self.dismiss(animated: true)

        } else {
            if reasons[indexPath.row] == "Other" {
                if objectNavigation == "True" {
                    textview.isHidden = true
                   

                }else{
                    textview.isHidden = false
                    textview.becomeFirstResponder()
                }
              
            } else {
                textview.isHidden = true
                textview.resignFirstResponder()
                configureTextViewAsPlaceholder()
            }
            
        }
        tableView.reloadData()

//        if objectNavigation == "True" {
//             
//        } else {
//            
//            
//        } self.onApplyTappedSorting!("",:"")
//        self.dismiss(animated: true)
          
        }
    
    
}
