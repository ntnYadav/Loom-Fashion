import UIKit
import SVGKit
import SDWebImage

class LMWalletVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    lazy fileprivate var viewmodel = LMWalletMV(hostController: self)
    @IBOutlet weak var tblWallet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    override func viewWillAppear(_ animated: Bool) {
        viewmodel.validateValueWallet()
    }
    @IBAction func actBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 350
        } else if indexPath.row == 0 {
            return 50
        } else {
            return 88
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.model?.history?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tblWallet.showsVerticalScrollIndicator = true

        let obj = viewmodel.model?.history?[indexPath.row]
        
        if indexPath.row == 0 {
            let cell = tblWallet.dequeueReusableCell(withIdentifier: "LMWalletCell", for: indexPath) as! LMWalletCell
            //D1cfcf   50
            cell.viewMain1.layer.cornerRadius = cell.viewMain1.frame.size.width / 2
            cell.view2.layer.cornerRadius = 5
            cell.view1.layer.cornerRadius = 5
            cell.viewinner.layer.cornerRadius = cell.viewinner.frame.size.width / 2
            cell.viewinner1.layer.cornerRadius = cell.viewinner1.frame.size.width / 2
            cell.view2.layer.borderColor = UIColor.lightGray.cgColor
            cell.view2.layer.borderWidth = 0.7
            cell.view1.layer.borderColor = UIColor.lightGray.cgColor
            cell.view1.layer.borderWidth = 0.7
            cell.imgCoin.image = SVGKImage(named: "ic_rupes")?.uiImage
            cell.imgcoin1.image = UIImage(named: "rupee-svgrepo-com")

           // cell.imgcoin1.image = SVGKImage(named: "ic_dollor")?.uiImage
            cell.imgWallet.image = UIImage(named: "wallet")
            cell.lblCoin1.text = "\(viewmodel.model?.pointsBalance ?? 0)"
            cell.lblCoin2.text =  keyName.rupessymbol + "\(viewmodel.model?.walletBalance ?? 0 )"
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 1 {
            let cell = tblWallet.dequeueReusableCell(withIdentifier: "LMWalletCell1", for: indexPath) as! LMWalletCell1
            cell.backgroundColor = UIColor(red: 209/255.0, green: 207/255.0, blue: 207/255.0, alpha: 0.3)
            cell.layer.cornerRadius = 8
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell.clipsToBounds = true
            cell.selectionStyle = .none
            cell.lbl.text = "Recent Transactions"

            return cell
        } else {
            
            if obj?.description == "Bonus points" {
                let cell = tblWallet.dequeueReusableCell(withIdentifier: "LMWalletCell1", for: indexPath) as! LMWalletCell1
                cell.backgroundColor = UIColor(red: 209/255.0, green: 207/255.0, blue: 207/255.0, alpha: 0.3)
                cell.layer.cornerRadius = 8
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                cell.clipsToBounds = true
                cell.selectionStyle = .none
                cell.lbl.text = "No Wallet Transactions Yet"
                cell.lbl.font = UIFont(name: ConstantFontSize.regular, size: 14)
                return cell

            } else {
                let cell = tblWallet.dequeueReusableCell(withIdentifier: "LMWalletCell2", for: indexPath) as! LMWalletCell2
                cell.selectionStyle = .none
                if indexPath.row % 2 == 0 {
                    cell.backgroundColor = UIColor(red: 209/255.0, green: 207/255.0, blue: 207/255.0, alpha: 0.3)
                    } else {
                        cell.backgroundColor = .clear
                    }
                cell.lbl1.text = obj?.description
                let formatted = formatDate(obj?.createdAt)
                cell.lbl2.text = formatted
       
                if (obj?.type == "points") {
                   // cell.img.image = UIImage(named: "ic_dollor")
                    cell.img.image = UIImage(named: "rupee-svgrepo-com")

                    //cell.img.image = SVGKImage(named: "ic_dollor")?.uiImage
                    if (obj?.txnType == "earn" || obj?.txnType == "credit") {
                        cell.lbl3.text =   "+" + keyName.rupessymbol + "\(obj?.points ?? 0)" + "pts"
                        cell.lbl3.textColor = UIColor(hex: 0x32B05F)
                    } else {
                        cell.lbl3.textColor = UIColor(hex: 0xCBCB0A)
                        cell.lbl3.text =   "-" + keyName.rupessymbol +  "\(obj?.points ?? 0)" + "pts"
                    }
                } else {
                    cell.img.image = SVGKImage(named: "ic_rupes")?.uiImage
                    if (obj?.txnType == "earn" || obj?.txnType == "credit") {
                        cell.lbl3.text =   "+" + keyName.rupessymbol +  "\(obj?.amount ?? 0)"
                        cell.lbl3.textColor = UIColor(hex: 0x32B05F)
                    } else {
                        cell.lbl3.textColor = UIColor(hex: 0xF44336)
                        cell.lbl3.text =   "-" + keyName.rupessymbol +  "\(obj?.amount ?? 0)"
                    }
                }
                return cell
            }
          
        }
    }
    
    

}
class LMWalletCell : UITableViewCell{
    @IBOutlet weak var viewinner1: UIView!
    @IBOutlet weak var viewinner: UIView!
    @IBOutlet weak var viewMain1: UIView!
    @IBOutlet weak var imgWallet: UIImageView!
    @IBOutlet weak var imgcoin1: UIImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var imgCoin: UIImageView!
    @IBOutlet weak var lblCoin2: UILabel!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var lblCoin1: UILabel!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var lblOrder: UILabel!
    @IBOutlet weak var lblOfferName: UILabel!
    @IBOutlet weak var view1: UIView!
}
class LMWalletCell1 : UITableViewCell{
    @IBOutlet weak var lbl: UILabel!
}
class LMWalletCell2 : UITableViewCell{

    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var img: UIImageView!
}

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255.0,
            green: CGFloat((hex >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            alpha: alpha
        )
    }
}
func formatDate(_ isoDate: String?) -> String {
    guard let isoDate = isoDate else { return "" }

    let inputFormatter = ISO8601DateFormatter()
    inputFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "MMM dd, yyyy hh:mm a"
    outputFormatter.amSymbol = "AM"
    outputFormatter.pmSymbol = "PM"
    outputFormatter.timeZone = TimeZone.current // or use .autoupdatingCurrent

    if let date = inputFormatter.date(from: isoDate) {
        return outputFormatter.string(from: date)
    } else {
        return ""
    }
}
