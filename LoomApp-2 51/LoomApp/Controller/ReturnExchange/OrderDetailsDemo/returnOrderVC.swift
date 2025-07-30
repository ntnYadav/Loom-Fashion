//
//  ViewController.swift
//  OrderDetailsDemo
//
//  Created by Abdul Quadir on 10/07/25.
//

import UIKit


class returnOrderVC: UIViewController, ExchangeCellDelegate, ChangeAddressCellDelegate,ConfirmAddressCellDelegate,ConfirmAddressCellDelegate1 {

        var objAddress: Addresslisting?
    var objAddress1: Addresslisting?

        var modelObj:OrderItemData?
        lazy fileprivate var viewmodel = LMReturnsMV(hostController: self)
        var imagesArray: [String]?  = []
        var pickAddress         = true
        var flagAddressDelivery = true
        var flagAddressPickUpDelivery = true

    var userName: String = ""
    var userAccount: String = ""
    var userIfcode: String = ""
    
       var selectedReason: String = ""
       var selectedCommented: String = ""
       var replacementVaientId: String = ""
       var refundMethod: String = ""
      var ReturnTypesCheck: String = "" // "wallet" or "bank"

    var address1: String = ""
    var address2: String = ""

        var flag                = true
        var exchangeflag   = ""
        var addressfinal   = ""
        var addressfinalID = ""

        func didToggleCheckBox(isChecked: Bool) {
            
            if pickAddress == true {
                pickAddress = true
            } else {
                pickAddress = false
            }
            
              isConfirmAddressChecked = isChecked
//            tableview.beginUpdates()
//            tableview.endUpdates()
              tableview.reloadData()
        }
        var productId:String = keyName.emptyStr
        var defaultVaniantID:String = keyName.emptyStr

        var arrDtaFinal: [String] = ["image","Recived","Size","Damaged","Lower","Poor","TextView","ReturnHeader","PickUpAddress","Submit"]
        
        var arrDtaFinal1: [String] = ["image","Recived","Size","Damaged","Lower","Poor","TextView", "UploadImage","ReturnHeader","Exchange Option","PickUpDelivery","ReturnAmount" ,"PickUpAddress","Submit"]

        
        var arrDta: [String] = ["Received wrong item","Size issue","Damaged item","Lower price found","Poor quality"]
        
        var artitle = ["Size color, or style mismatch","Too small or too big","Torn,stained,or defective","Available cheaper elsewhere","Fabric feels cheap"]
        
        
        let reasons: [[String: String]] = [
            ["title1": "Received wrong item", "detail": "Size color, or style mismatch"],
            ["title1": "Received wrong item", "detail": "Size color, or style mismatch"],
            ["title1": "Size issue", "detail": "Too small or too big"],
            ["title1": "Damaged item", "detail": "Torn, stained, or defective"],
            ["title1": "Lower price found", "detail": "Available cheaper elsewhere"],
            ["title1": "Poor quality", "detail": "Fabric feels cheap"],
            ["title1": "Poor quality", "detail": "Fabric feels cheap"],
            ["title1": "Poor quality", "detail": "Fabric feels cheap"],
            ["title1": "Poor quality", "detail": "Fabric feels cheap"]



        ]
        
        @IBOutlet weak var tableview: UITableView!
        
        var selectedOption: String? = nil  // "exchange" or "refund" or nil
        var selectedReasonIndex: Int? = nil
        var selectedBankIndexPath: IndexPath?
        var selectedBankOption: String = "" // "wallet" or "bank"
        var isConfirmAddressChecked = false



        var selectedImage: [UIImage] = []
        var shouldShowCellType4: Bool {
            return selectedReasonIndex == 0 || selectedReasonIndex == 2
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            flagAddressDelivery = true
            flagAddressPickUpDelivery = true
            address1 = ""
            address2 = ""
            ReturnTypesCheck = ""
            tableview.register(UINib(nibName: "WalletDetailTableCell12", bundle: nil), forCellReuseIdentifier: "WalletDetailTableCell12")

            // Do any additional setup after loading the view.
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                tapGesture.cancelsTouchesInView = false
                view.addGestureRecognizer(tapGesture)
            tableview.allowsSelection = false
            viewmodel.validateValue(productId: productId, defaultVaniantID: defaultVaniantID)

    //        tableview.separatorStyle = .none//border
            
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

    @IBAction func submitDetailsActBtn(_ sender: Any) {
        
        
        if selectedReason.isEmpty {
            self.showToastView(message: "Please select the reason")
            
        } else if ReturnTypesCheck.isEmpty {
            self.showToastView(message: "Please select the return type")
            
        } else if ReturnTypesCheck == "exchange", replacementVaientId.isEmpty {
            self.showToastView(message: "Please select the color and size")
            
        } else if ReturnTypesCheck == "refund", selectedBankOption.isEmpty {
            self.showToastView(message: "Please select the wallet or bank detail")
            
        } else if address1 == "" {
            self.showToastView(message: "Please enter the pickUp address")
            
        } else if ReturnTypesCheck == "exchange" {
            if address2 == "" {
                self.showToastView(message: "Please enter the pickUp delivery address")
            } else {
                print("Your Details Submit!")
                let objModel = modelObj

                viewmodel.validateValueSubmitAPI(
                    orderId: objModel?.orderId ?? "",
                    orderItemId: objModel?.itemId ?? "",
                    pickupAddress: objAddress?.id ?? "",
                    images: self.imagesArray ?? [],
                    reason: selectedReason,
                    comments: "",
                    type: ReturnTypesCheck,
                    productId: objModel?.productId ?? "",
                    replacementVariantId: replacementVaientId,
                    deliveryAddress: objAddress1?.id ?? "",
                    refundMethod: selectedBankOption,
                    upiId: "",
                    bankAccountNumber: userAccount,
                    ifscCode: userIfcode,
                    accountHolderName: userName,
                    refundDetails: []
                )
            }
            
        } else {
            // ✅ All validations passed — proceed
            print("Your Details Submit!")
            let objModel = modelObj
//            if objAddress.id != nil {
//
//            }
            viewmodel.validateValueSubmitAPI(
                orderId: objModel?.orderId ?? "",
                orderItemId: objModel?.itemId ?? "",
                pickupAddress: objAddress?.id ?? "",
                images: self.imagesArray ?? [],
                reason: selectedReason,
                comments: "",
                type: ReturnTypesCheck,
                productId: objModel?.productId ?? "",
                replacementVariantId: replacementVaientId,
                deliveryAddress: objAddress1?.id ?? "",
                refundMethod: selectedBankOption,
                upiId: "",
                bankAccountNumber: "",
                ifscCode: "",
                accountHolderName: "",
                refundDetails: []
            )
        }

    }
        
        /*
         {
           "orderId": "686fe87666ef3af54543717c",
           "orderItemId": "686fe87666ef3af54543717d",
           "type": "REFUND",
           "reason": "Product was defective",
           "comments": "Received a damaged item, want refund.",
           "pickupAddress": "685d38e08df211c1da3f50d9",
           "images": [],
           "refundMethod": "UPI",                // or "BANK_TRANSFER"
           "refundDetails": {
             "upiId": "8763747773@ybl",                // required if refundMethod is UPI
             "bankAccountNumber": "",            // required if refundMethod is BANK_TRANSFER
             "ifscCode": "",
             "bankName": "",
             "accountHolderName": ""
           }
         }
          
         http://localhost:3006/order/returns/return_request
          */
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }

        //check , hidden
        func didTapExchange(at indexPath: IndexPath) {
            selectedOption = "exchange"
            selectedBankOption = ""
            ReturnTypesCheck = "exchange"

           // var arrDtaFinal: [String] = ["image","Recived","Size","Damaged","Lower","Poor","TextView","ReturnHeader","PickUpAddress" ,"PickUpDelivery","Submit"]
            
            if flag == false {
                exchangeflag = "exchange"

                arrDtaFinal = ["image","Recived","Size","Damaged","Lower","Poor","TextView", "UploadImage","ReturnHeader","Exchange Option","PickUpAddress","PickUpDelivery","Submit"]
            } else {
                arrDtaFinal = ["image","Recived","Size","Damaged","Lower","Poor","TextView","ReturnHeader","Exchange Option","PickUpAddress","PickUpDelivery","Submit"]
            }
            tableview.reloadData()
            
        }
        
        func didTapRefund(at indexPath: IndexPath) {
            selectedOption = "refund"
            selectedBankOption = "" // reset
            ReturnTypesCheck = "refund"
            
            if flag == false {
                
                exchangeflag = "refund"
                arrDtaFinal = ["image","Recived","Size","Damaged","Lower","Poor","TextView", "UploadImage","ReturnHeader","ReturnAmount","PickUpAddress","Submit"]
            } else {
                arrDtaFinal = ["image","Recived","Size","Damaged","Lower","Poor","TextView","ReturnHeader","ReturnAmount" ,"PickUpAddress","Submit"]
            }

            tableview.reloadData()
        }
        
        @IBAction func actBack(_ sender: Any) {
            navigationController?.popViewController(animated: true)
        }
    
    func didTapConfirmAddress1() {
        
    }
    
    func didToggleCheckBox1(isChecked: Bool) {
        //flagAddressDelivery = true
        if pickAddress == true {
            pickAddress = false
        } else {
            flagAddressDelivery = true
            pickAddress = true
        }
        
          isConfirmAddressChecked = isChecked
//            tableview.beginUpdates()
//            tableview.endUpdates()
          tableview.reloadData()
    }
    }

extension returnOrderVC: UITableViewDelegate, UITableViewDataSource,PhotosAddCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate ,PhotosEditDelegate ,PhotosSizeDelegate {
    
    func didTapSizeClassImage1(ndex: Int, arrSize: [SizeVariant]) {
        replacementVaientId = arrSize[ndex].variantId ?? ""
    }
    

    func didTapSizeClassImage(ndex: Int, arrSize: [ColorVariant]) {
        print(arrSize[ndex])
        
        arrDtaFinal = ["image","Recived","Size","Damaged","Lower","Poor","TextView", "UploadImage","ReturnHeader","Exchange Option","ImageSize","PickUpAddress","PickUpDelivery","Submit"]
        tableview.reloadData()
    }
    
    
    
    func didTapSizeClassImage(ndex: Int, arrSize: [SizeVariant]) {
        
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrDtaFinal.count
  
        }



    //2ad
    
   
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var currentIndex = 0
            let obj = arrDtaFinal[indexPath.row]
            let objModel = modelObj

            if obj == "image" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReturnUserDetail", for: indexPath) as! ReturnUserDetail
                //cell.lblproductName.text = modelObj?.itemStatus

                
                if let productTitle = objModel?.productTitle {
                    cell.lblProductName.text = "\(productTitle)"
                }
                
                

                let walletAmount = LMGlobal.shared.removeDecimal(from: objModel?.priceSnapshot?.walletCreditUsed ?? 0)
                let sellingPrice = LMGlobal.shared.removeDecimal(from: objModel?.priceSnapshot?.sellingPrice ?? 0)

                if walletAmount == "0" {
                    cell.lblpricedetail.text = "\(keyName.rupessymbol)\(sellingPrice)"
                } else {
                    cell.lblpricedetail.text = "\(keyName.rupessymbol)\(sellingPrice)" +  " \(keyName.rupessymbol)\(walletAmount)" + " (Wallet)"
                }

                let sizeText  = objModel?.size ?? ""
                let colorText = objModel?.color ?? ""
                let qty       = "\(objModel?.quantity ?? 0)"
                //let quantityText = qty.map { "\($0)" }  // if quantity is Int?
                cell.lblProductSize.text = "\(sizeText) | \(colorText) | \(qty)"
                cell.img.sd_setImage(with: URL(string:objModel?.productImage ?? keyName.emptyStr))

                return cell
            }
  
            if obj == "Recived" || obj == "Size" || obj == "Damaged" || obj == "Lower" || obj == "Poor"{
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellType2", for: indexPath) as! returnTableViewCell
                if obj == "Recived" {
                    cell.titleNameProducts.isHidden = false
                } else {
                    cell.titleNameProducts.isHidden = true

                }
                let medol = reasons[indexPath.row]
                cell.lblName.text     = reasons[indexPath.row]["title1"] ?? ""
                cell.lblNameSize.text = reasons[indexPath.row]["detail"] ?? ""
                let dataIndex = indexPath.row - currentIndex

                          let isSelected = (selectedReasonIndex == dataIndex)
                          cell.btn1.setImage(UIImage(named: isSelected ? "fillcircle" : "circle"), for: .normal)
                          cell.btn1.isSelected = isSelected
                          cell.btn1.backgroundColor = isSelected ? .white : .clear
                
                          cell.btn1.tag = dataIndex
                          cell.btn1.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                          return cell
            }
            
            if obj == "TextView" {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellType3", for: indexPath) as! textviewTableCell
                
                selectedCommented = cell.textview.text ?? ""
                print(selectedCommented)
                return cell
            }
            if obj == "UploadImage" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellType4", for: indexPath) as! photosAddTableViewCell
                cell.delegate = self
                cell.images = selectedImage
                return cell
            }
           
            if obj == "ReturnHeader" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellType5", for: indexPath) as! exchangeTableCell
                cell.delegate  = self
                cell.indexPath = indexPath
                let isExchange = selectedOption == "exchange"
                let isRefund   = selectedOption == "refund"
                cell.exchangeBtn.setImage(UIImage(named: isExchange ? "fillcircle" : "circle"), for: .normal)
                cell.refundBtn.setImage(UIImage(named: isRefund ? "fillcircle" : "circle"), for: .normal)
                return cell
            }
            if obj == "Exchange Option" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellType6", for: indexPath) as! tableClectionCell
                cell.arrColor = viewmodel.modelproduct?.colors ?? []
                cell.delegate = self

                return cell

            }
            if obj == "ImageSize" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellType11", for: indexPath) as! sizeTableViewCell
                cell.arrSize = viewmodel.modelproduct?.variantsColor?[0].sizes ?? []
                cell.delegate = self
                return cell

            }
            
            if obj == "ReturnAmount" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellType8", for: indexPath) as! bankTableCell
                cell.delegate = self
                cell.indexPath = indexPath
                
                
                let walletAmount = LMGlobal.shared.removeDecimal(from: objModel?.priceSnapshot?.walletCreditUsed ?? 0)
                let sellingPrice = LMGlobal.shared.removeDecimal(from: objModel?.priceSnapshot?.sellingPrice ?? 0)

                if walletAmount == "0" {
                    cell.lblRefundAmount.text = "Refund Amount: \(keyName.rupessymbol)\(sellingPrice)"
                } else {
                   cell.lblRefundAmount.text = "Refund Amount: \(keyName.rupessymbol)\(sellingPrice) " + " \(keyName.rupessymbol)\(walletAmount)" + " (Wallet)"
                }
                
                
                //cell.lblRefundAmount.text = lblRefundAmount
                let isWallet = selectedBankOption == "wallet"
                let isBank = selectedBankOption == "bank"
                cell.walletBtn.setImage(UIImage(named: isWallet ? "fillcircle" : "circle"), for: .normal)
                cell.bankAccountBtn.setImage(UIImage(named: isBank ? "fillcircle" : "circle"), for: .normal)
                cell.configure(isBankSelected: isBank)
                return cell
            }
            if obj == "PickUpDelivery" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "WalletDetailTableCell12", for: indexPath) as! WalletDetailTableCell12
//                cell.checkBtn.addTarget(self, action: #selector(returnOrderVC.pickaddress(_:)), for: .touchUpInside)
                cell.delegate = self
                cell.btnchange.layer.borderColor = UIColor.black.cgColor
                cell.btnchange.layer.borderWidth = 1.0
                cell.btnchange.clipsToBounds = true
                cell.btnchange.addTarget(self, action: #selector(buttonchangePickUPAddress(_:)), for: .touchUpInside)

                if flagAddressPickUpDelivery == true {
                    
                    if pickAddress == false  {
                        cell.btnchange.isHidden   = false
                        cell.viewaddress.isHidden = true
                        cell.lbladdress.isHidden  = true
                        cell.lblpincode.isHidden  = true
                        cell.lblName.isHidden     = true
                        cell.lblPhone.isHidden    = true
                    } else {
                        cell.btnchange.isHidden   = true
                    }
                } else {
                    cell.btnchange.isHidden   = false
                    cell.viewaddress.isHidden = false
                    cell.lbladdress.isHidden  = false
                    cell.lblpincode.isHidden  = false
                    cell.lblName.isHidden     = false
                    cell.lblPhone.isHidden    = false
                    address2 = "pick"

                    if let objAddress = objAddress1 {
                        let fullAddress = [
                            objAddress.houseNumber,
                            objAddress.area,
                        ].filter { !$0.isEmpty }.joined(separator: ", ")
                        
                        cell.lbladdress.text = fullAddress
                    }
                    if let objAddress = objAddress1 {
                        let fullAddress = [
                            objAddress.city,
                            objAddress.state,
                            objAddress.pinCode
                        ].filter { !$0.isEmpty }.joined(separator: ", ")
                        
                        cell.lblpincode.text = fullAddress
                    }
                    cell.lblName.text     =  objAddress1?.name
                    cell.lblPhone.text    = "Phone No: " + (objAddress1?.mobile ?? "")
                }
               
                return cell
            }
            
            if obj == "PickUpAddress" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellType7", for: indexPath) as! pickupAdressTblCell
                
                cell.changeBtn.addTarget(self, action: #selector(buttonchangeAddress(_:)), for: .touchUpInside)

                if flagAddressDelivery == true {
                    cell.changeBtn.isHidden = false
                    cell.lblAdress.isHidden = true
                    cell.lblName.isHidden = true
                    cell.lblPhone.isHidden = true
                   // cell.lblCity.isHidden = true

                } else {
                    cell.changeBtn.isHidden = true
                    address1 = "pick"
                    if let objAddress = objAddress {
                        let fullAddress = [
                            objAddress.houseNumber,
                            objAddress.area,
                            objAddress.city,
                            objAddress.state,
                            objAddress.country
                        ].filter { !$0.isEmpty }.joined(separator: ", ")
                        
                        cell.lblAdress.text = fullAddress
                        //cell.lblCity.text = objAddress.pinCode
                    }
                    
                    cell.lblName.text     =  objAddress?.name
                    cell.lblPhone.text    = "Phone No: " + (objAddress?.mobile ?? "")
                    
                        cell.lblName.isHidden = false
                        cell.lblPhone.isHidden = false
                        cell.lblAdress.isHidden = false

                    
                }
            
                
                
                
//                if let name = THUserDefaultValue.userFirstName  {
//                    cell.lblName.text = name
//                }
               // cell.lblAdress.text = addressfinal  // ✅

                
//                if let phoneNumber = THUserDefaultValue.phoneNumber {
//                    let parsed = phoneNumber.replacingOccurrences(of: "+91", with: "")
//                    cell.lblPhone.text  = "Phone Number :" + parsed
//                }
               
                
                cell.delegate = self
                return cell
            }
            
            if obj == "Submit" {
                return tableView.dequeueReusableCell(withIdentifier: "CellType10", for: indexPath)

            }

            return UITableViewCell()
        }

     
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            let obj = arrDtaFinal[indexPath.row]
            
            if obj == "image" {
                return 170
            }
            if obj == "PickUpDelivery" {
                if flagAddressPickUpDelivery == true {
                    if pickAddress == true {
                        return 100
                    } else {
                        return 200
                    }
                } else {
                    return 320
                }
            }
            if obj == "ImageSize" {
                return 100
            }
            if obj == "Recived" || obj == "Size" || obj == "Damaged" || obj == "Lower" || obj == "Poor"{
                return 110

            } else if obj == "UploadImage" {
                if selectedImage.count != 0 {
                    return 400
                } else {
                    return 220
                }
            } else {
                return UITableView.automaticDimension
            }
        }

       
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("ok")
            if indexPath.row == arrDta.count + 1 {
                   if let cell = tableview.cellForRow(at: indexPath) as? textviewTableCell {
                       cell.textview.becomeFirstResponder()
                   }
               }
        }
        
   
    
    @objc func pickaddress(_ sender : UIButton) {
        let tag = sender.tag
        
    }
   
    @objc func buttonchangeAddress(_ sender: UIButton) {
        
    }
        @objc func buttonTapped(_ sender: UIButton) {
            print("Select 2 roww data: \(sender.tag)")
            let tappedIndex = sender.tag

            if selectedReasonIndex == tappedIndex {
                arrDtaFinal = ["image","Recived","Size","Damaged","Lower","Poor","TextView","ReturnHeader","PickUpAddress" ,"Submit"]
                if exchangeflag == "exchange" {
                    arrDtaFinal = ["image","Recived","Size","Damaged","Lower","Poor","TextView", "UploadImage","ReturnHeader","Exchange Option","PickUpAddress","PickUpDelivery","Submit"]

                }
                if exchangeflag == "refund" {
                    arrDtaFinal = ["image","Recived","Size","Damaged","Lower","Poor","TextView", "UploadImage","ReturnHeader","ReturnAmount","PickUpAddress","Submit"]
                }
                selectedReasonIndex = nil
            } else {
                
                if tappedIndex == 1 ||  tappedIndex == 3{
                    flag = false
                    arrDtaFinal = ["image","Recived","Size","Damaged","Lower","Poor","TextView","UploadImage","ReturnHeader","PickUpAddress" ,"Submit"]
                    if exchangeflag == "exchange" {
                        arrDtaFinal = ["image","Recived","Size","Damaged","Lower","Poor","TextView", "UploadImage","ReturnHeader","Exchange Option","PickUpAddress","PickUpDelivery","Submit"]

                    }
                    if exchangeflag == "refund" {
                        arrDtaFinal = ["image","Recived","Size","Damaged","Lower","Poor","TextView", "UploadImage","ReturnHeader","ReturnAmount","PickUpAddress","Submit"]
                    }
                } else {

                    arrDtaFinal = ["image","Recived","Size","Damaged","Lower","Poor","TextView","ReturnHeader","PickUpAddress" ,"Submit"]
                    if exchangeflag == "exchange" {
                        arrDtaFinal = ["image","Recived","Size","Damaged","Lower","Poor","TextView", "UploadImage","ReturnHeader","Exchange Option","PickUpAddress","PickUpDelivery","Submit"]

                    }
                    if exchangeflag == "refund" {
                        arrDtaFinal = ["image","Recived","Size","Damaged","Lower","Poor","TextView", "UploadImage","ReturnHeader","ReturnAmount","PickUpAddress","Submit"]
                    }
                }
                
                selectedReason = arrDtaFinal[tappedIndex]
                selectedReasonIndex = tappedIndex
            }


            
            tableview.reloadData()

        }
        
        //img picker
        func didTapCamera() {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let picker = UIImagePickerController()
                    picker.sourceType = .camera
                    picker.delegate = self
                    picker.allowsEditing = true
                    present(picker, animated: true, completion: nil)
                } else {
                    print("Camera not available")
                }
        }
        
        func didTapGallery() {
            let picker = UIImagePickerController()
                    picker.sourceType = .photoLibrary
                    picker.delegate = self
                    picker.allowsEditing = true
                    present(picker, animated: true, completion: nil)
        }
  
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true) { [weak self] in
                guard let self = self else { return }

                if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
                    if self.selectedImage.count < 4 {
                        
                        self.viewmodel.uploadImageToServer(image: image) { result in
                            GlobalLoader.shared.hide()
                            switch result {
                            case .success(let url):
                                self.imagesArray?.append(url)
                                print("✅ Uploaded: \(url)")
                            case .failure(let err):
                                print("❌ Upload failed: \(err)")
                            }
                        }
                        
                        self.selectedImage.append(image)

                        DispatchQueue.main.async {
                            print("saved image!")
                            self.tableview.beginUpdates() //Smooth height
                            self.tableview.endUpdates()
                            self.tableview.reloadData()
                        }
                    } else {
                        print("Maximum 4 images allowed.")
                    }
                }
            }
        }



        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
        
    }

    //check bank
    extension returnOrderVC: BankCellDelegate {
     
        func didTapWallet() {
            selectedBankOption = "wallet"
            tableview.reloadData()
        }

        func didTapBankAccount() {
            selectedBankOption = "bank"
            tableview.reloadData()
        }
        func didTapDeleteImage(at index: Int) {
            guard index >= 0 && index < selectedImage.count else { return }
            selectedImage.remove(at: index)

            // Reload only the photo cell row
            tableview.reloadRows(at: [IndexPath(row: arrDta.count + 2, section: 0)], with: .automatic)
        }
        func didTapAddBank() {
            
            let vc = storyboard?.instantiateViewController(identifier: "addBankDetails") as! addBankDetails
            vc.onBankSelected = { ifcscode, accountNumber, accountName in
                self.userName = accountName
                self.userIfcode = ifcscode
                self.userAccount = accountNumber
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        func didTapConfirmAddress() {
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let modalVC = storyboard.instantiateViewController(withIdentifier:VcIdentifier.LMAddresslistVC) as? LMAddresslistVC {
                modalVC.flagAddressDirectionCheck1 = true
                modalVC.flagAddressDirectionCheck = true

               // modalVC.addressID = addresID
                modalVC.onAddressSelectedreturn = { addressObj in
                        self.objAddress = addressObj
                        self.tableview.reloadData()
                }
                
                self.navigationController?.pushViewController(modalVC, animated: true)
            }
            
        }
        @objc func buttonchangePickUPAddress(_ sender: UIButton) {
            print("Button tapped at row: \(sender.tag)")
            /// Address Delivery On and Off    PickUpDelivery
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let modalVC = storyboard.instantiateViewController(withIdentifier:VcIdentifier.LMAddresslistVC) as? LMAddresslistVC {
                modalVC.flagAddressDirectionCheck1 = true
                modalVC.flagAddressDirectionCheck = true

               // modalVC.addressID = addresID
                modalVC.onAddressSelectedreturn = { addressObj in
                    if addressObj == nil {
                        self.showToastView(message: "Please select the Delivery address")

                    } else {
                        self.flagAddressPickUpDelivery = false
                        self.objAddress1 = addressObj
                        self.tableview.reloadData()
                    }
                }
                
                self.navigationController?.pushViewController(modalVC, animated: true)
            }
        }
        
        func didTapChangeAddress() {
          //Pickup Address navigation
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let modalVC = storyboard.instantiateViewController(withIdentifier:VcIdentifier.LMAddresslistVC) as? LMAddresslistVC {
                modalVC.flagAddressDirectionCheck1 = true
                modalVC.flagAddressDirectionCheck = true

               // modalVC.addressID = addresID
                modalVC.onAddressSelectedreturn = { addressObj in
                    if addressObj == nil {
                        self.showToastView(message: "Please select the pickup address")

                    } else {
                        self.flagAddressDelivery = false
                        self.objAddress = addressObj
                        
                        self.tableview.reloadData()
                    }
                }
                
                self.navigationController?.pushViewController(modalVC, animated: true)
            }
            
            

        }
        
 
    }


    extension Array {
        subscript(safe index: Int) -> Element? {
            return indices.contains(index) ? self[index] : nil
        }
    }


