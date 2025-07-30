//
//  LMProductDetailVC.swift
//  LoomApp
//
//  Created by Flucent tech on 07/04/25.
//
import UIKit

class LMAddresslistVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var onAddressSelected: ((String, String) -> Void)?
    var onAddressSelectedreturn: ((Addresslisting?) -> Void)?
    var strAddress: String = keyName.name
    var strName: String = ""
    var strmobile: String = ""
    var objAddressfinal1: Addresslisting?

    var addressID : String = ""
    var addList : String = ""

    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var viewEmpty: UIView!

    @IBOutlet weak var viewBottom: UIView!
    var selectCell: IndexPath? = nil
    var flagAddressDirectionCheck: Bool = false
    var flagAddressDirectionCheck1: Bool = false

    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var tblAddlist: UITableView!
    lazy private var viewmodel = LMAddressListMV(hostController: self)
    var strClickAct: String = ""
    var arrcount: Int = 0
    let arrCotegory = ["All", "Shirts", "T-shirts", "Jeans", "Trouser", "Jacket", "Sweaters", "Swearshirt", "Shorts", "All", "Shirts", "T-shirts", "Jeans", "Trouser", "Jacket", "Sweaters", "Swearshirt", "Shorts"]
    var selectedCell = [IndexPath]()
    var timer = Timer()
    var counter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblError.isHidden = false
        tblAddlist.isHidden = true
        viewmodel.validateValue()
        if flagAddressDirectionCheck == true {
            viewBottom.isHidden = false
            viewBottom.layer.frame.size.height = 50
        } else {
            viewBottom.layer.frame.size.height = 0
            viewBottom.isHidden = true
        }
        initset()
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
    func initset() {
        viewmodel.validateValue()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewmodel.model?.defaultAddress != nil {
            return (viewmodel.model?.otherAddresses.count ?? 0) + 1
        }
        return viewmodel.model?.otherAddresses.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewmodel.model?.defaultAddress != nil {
            if indexPath.row == 0 {
                return 220
            } else if indexPath.row == 1 {
                return 220
            } else {
                return 190
            }
        } else {
            if indexPath.row == 0 {
                return 220
            } else {
                return 190
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tblAddlist.separatorColor = .clear

        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)

        let hasDefaultAddress = (viewmodel.model?.defaultAddress != nil)
        let isDefaultRow = (hasDefaultAddress && indexPath.row == 0)

        let cell = tblAddlist.dequeueReusableCell(withIdentifier: CellIdentifier.LMAddresslistCell, for: indexPath) as! LMAddresslistCell
        cell.selectionStyle = .none

        // Set header height and text depending on default address and row
        if isDefaultRow {
            cell.headerheightconstraint.constant = 40
            cell.lblHeader.text = keyName.DefaultAddress
        } else if hasDefaultAddress && indexPath.row == 1 {
            cell.headerheightconstraint.constant = 40
            cell.lblHeader.text = keyName.otherSave
        } else if !hasDefaultAddress && indexPath.row == 0 {
            cell.headerheightconstraint.constant = 40
            cell.lblHeader.text = keyName.otherSave
        } else {
            cell.headerheightconstraint.constant = 0
            cell.lblHeader.text = ""
        }

        // Configure cell data
        if isDefaultRow {
            if let obj = viewmodel.model?.defaultAddress {
                cell.btnedit.tag = indexPath.row
                cell.btndelete.tag = indexPath.row
                cell.lblName.text = obj.name ?? ""
                cell.lblAddress.text = (obj.houseNumber ?? "") + " " + (obj.area ?? "")
                cell.lblCity.text = (obj.city ?? "") + " " + (obj.state ?? "")
                cell.lblPhonenumber.text = "Phone Number: " + (obj.mobile ?? "")

                cell.btndelete.addTarget(self, action: #selector(LMAddresslistVC.delegateaddress(_:)), for: .touchUpInside)
                cell.btnedit.addTarget(self, action: #selector(LMAddresslistVC.Editaddress(_:)), for: .touchUpInside)

                if flagAddressDirectionCheck {
                    cell.btnSelect.isHidden = false
                    cell.viewWidthCOnstraint.constant = 25
                    cell.btndelete.isHidden = true
                } else {
                    cell.btnSelect.isHidden = true
                    cell.viewWidthCOnstraint.constant = 0
                }

                if selectCell == indexPath || addressID == (obj.id ?? "") {
                    selectCell = nil
                    addressID = obj.id ?? ""
                    strAddress = (obj.houseNumber ?? "") + " " + (obj.area ?? "") + " " + (obj.city ?? "") + " " + (obj.state ?? "")
                    cell.btnSelect.setImage(UIImage(named: "fillcircle.png"), for: .normal)
                } else {
                    cell.btnSelect.setImage(UIImage(named: "circle.png"), for: .normal)
                }
            }
        } else {
            // Other addresses
            // Adjust index based on whether default address exists
            let adjustedIndex = hasDefaultAddress ? indexPath.row - 1 : indexPath.row

            if let obj = viewmodel.model?.otherAddresses[safe: adjustedIndex] {
                cell.btnedit.tag = indexPath.row
                cell.btndelete.tag = indexPath.row
                cell.lblName.text = obj.name ?? ""
                cell.lblAddress.text = (obj.houseNumber ?? "") + " " + (obj.area ?? "")
                cell.lblCity.text = (obj.city ?? "") + " " + (obj.state ?? "")
                cell.lblPhonenumber.text = "Phone Number: " + (obj.mobile ?? "")

                cell.btndelete.addTarget(self, action: #selector(LMAddresslistVC.delegateaddress(_:)), for: .touchUpInside)
                cell.btnedit.addTarget(self, action: #selector(LMAddresslistVC.Editaddress(_:)), for: .touchUpInside)

                if flagAddressDirectionCheck {
                    cell.btnSelect.isHidden = false
                    cell.viewWidthCOnstraint.constant = 25
                    cell.btndelete.isHidden = true
                } else {
                    cell.btnSelect.isHidden = true
                    cell.viewWidthCOnstraint.constant = 0
                }

                if selectCell == indexPath || addressID == (obj.id ?? "") {
                    selectCell = nil
                    addressID = obj.id ?? ""
                    strAddress = (obj.houseNumber ?? "") + " " + (obj.area ?? "") + " " + (obj.city ?? "") + " " + (obj.state ?? "")
                    cell.btnSelect.setImage(UIImage(named: "fillcircle.png"), for: .normal)
                } else {
                    if viewmodel.model?.otherAddresses.count ==  1{
                        cell.btnSelect.setImage(UIImage(named: "fillcircle.png"), for: .normal)
                        selectCell = indexPath
                        addressID = obj.id ?? ""
                        strAddress = (obj.houseNumber ?? "") + " " + (obj.area ?? "") + " " + (obj.city ?? "") + " " + (obj.state ?? "")
                    } else {
                        cell.btnSelect.setImage(UIImage(named: "circle.png"), for: .normal)

                    }
                    
                }
            }
        }

        cell.selectedBackgroundView = selectedView

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var obj: Addresslisting?

        let hasDefaultAddress = (viewmodel.model?.defaultAddress != nil)

        if hasDefaultAddress {
            if indexPath.row == 0 {
                obj = viewmodel.model?.defaultAddress
            } else {
                obj = viewmodel.model?.otherAddresses[safe: indexPath.row - 1]
            }
        } else {
            obj = viewmodel.model?.otherAddresses[safe: indexPath.row]
        }

        guard let phoneNumber = THUserDefaultValue.phoneNumber else {
            return
        }
       objAddressfinal1 = obj

        selectCell = indexPath
        addressID = obj?.id ?? ""
        self.tblAddlist.reloadData()
    }

    // MARK: - Action

    @objc func Editaddress(_ sender: UIButton) {
        let tag = sender.tag
        var objAddressfinal: Addresslisting?

        let hasDefaultAddress = (viewmodel.model?.defaultAddress != nil)

        if hasDefaultAddress {
            if tag == 0 {
                objAddressfinal = viewmodel.model?.defaultAddress
            } else {
                objAddressfinal = viewmodel.model?.otherAddresses[safe: tag - 1]
            }
        } else {
            objAddressfinal = viewmodel.model?.otherAddresses[safe: tag]
        }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMAddressAddVC1) as! LMAddressAddVC1
        secondVC.edit = keyName.Edit
        secondVC.modeldata = objAddressfinal
        self.navigationController?.pushViewController(secondVC, animated: true)
    }

    @objc func delegateaddress(_ sender: UIButton) {
        let tag = sender.tag
        let hasDefaultAddress = (viewmodel.model?.defaultAddress != nil)

        if tag == 0 && hasDefaultAddress {
            let obj = viewmodel.model?.defaultAddress
            viewmodel.deleteValue(addressId: obj?.id ?? keyName.emptyStr)
        } else {
            let adjustedIndex = hasDefaultAddress ? tag - 1 : tag
            let obj = viewmodel.model?.otherAddresses[safe: adjustedIndex]
            viewmodel.deleteValue(addressId: obj?.id ?? keyName.emptyStr)
        }
    }

    @IBAction func actAdd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMAddressAddVC1) as! LMAddressAddVC1
        secondVC.edit = keyName.emptyStr
        self.navigationController?.pushViewController(secondVC, animated: true)
    }

    @IBAction func actBack(_ sender: Any) {
        if flagAddressDirectionCheck1 == true {
            onAddressSelectedreturn?(objAddressfinal1)
            self.navigationController?.popViewController(animated: true)
        } else {
            onAddressSelected?(strAddress, addressID)
            self.navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func actFilter(_ sender: Any) {
        self.NavigationController(navigateFrom: self, navigateTo: LMFilterVC(), navigateToString: VcIdentifier.LMFilterVC)
    }

    @IBAction func actDeliverHere(_ sender: Any) {
        if flagAddressDirectionCheck1 == true {
            onAddressSelectedreturn?(objAddressfinal1)
            self.navigationController?.popViewController(animated: true)
        } else {
            onAddressSelected?(strAddress, addressID)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// Safe array index extension to avoid crashes if index is out of bounds
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
