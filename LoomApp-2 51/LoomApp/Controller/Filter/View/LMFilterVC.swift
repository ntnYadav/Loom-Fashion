
import UIKit

class LMFilterVC: UIViewController {
    
    var onStringSelected: ((String,Double,Double) -> Void)?

    var tempIndex = 0
    @IBOutlet weak var viewSlider: UIView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tblRow: UITableView!
    var itemsMaterialtemp = [String]()
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var btnCleanall: UIButton!
    @IBOutlet weak var appSlider: UISlider!
    @IBOutlet weak var showSliderValue: UILabel!
    
    @IBOutlet weak var btnproductcount: BorderedButton!
    @IBOutlet weak var slider: CustomSlider!
    @IBOutlet weak var btnApplyFilter: BorderedButton!
    @IBOutlet weak var btnclosedFilter: BorderedButton!

    @IBOutlet weak var lblSliderValue: UILabel!
    var minPrice:String = "0"
    var maxPrice:String = "5000"

    var selectedValuesByAttribute: [String: Set<String>] = [:]

    lazy fileprivate var viewmodel = LMFilterVM(hostController: self)

    var selectedIndexPath: IndexPath? = nil
    var selectedIndexPathRow: IndexPath? = nil
    var selectedRow:[IndexPath] = []

    let items = ["  PRICE HIGH TO LOW ","  PRICE LOW TO HIGH ","  AVG CUSTOMER REVIEW ","  Popular           ","  New  "]
    let itemsSize = [ " 28 "," 30 "," 32 "," 34 "," 36 "," 40 "," 42 "," 44 "," 46 "," 48 "," 50 "]
    let itemsColor = ["GRAY","BLACK","NAVY","BEIGE","BROWN","CREAM","GREEN","OLIVE","BLUE","WHITE"]
    let itemsPattern = [" PLAIN "," SELF-DESIGN "," TEXTURED "," STRIPES "," CHECK "]
    let itemsFit = [" SLIM FIT "," RELAXED FIT "," REGULAR FIT "]
    let itemsMaterial = [" COTTON "," POLYESTER "," LINEN "," RAYON "," TERRY ", " VISCOSE "]
    var arrSection = ["SORT BY","SIZE", "COLOR", "PATTERN", "FIT","MATERIAL","PRICE"]
    var arrSection1 = ["SORT BY","SIZE", "COLOR", "PATTERN", "FIT","MATERIAL","PRICE"]

    @IBOutlet weak var lblRightMax: UILabel!
    @IBOutlet weak var lblLeftMin: UILabel!
    override func viewDidLoad() {super.viewDidLoad()
        //https://product-api.loomfashion.co.in/product/admin/cat_sub/get_subcategories?page=1&pageSize=10
        viewmodel.getFilterdetail()
        
  

        applyStyle()
        setupRangeSlider()

//        let widthview = viewSlider.layer.frame.width
//        let rangeSlider = RangeSliderView(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
//        rangeSlider.minValue = Float(AppDelegate.shared.selectedValuesMin)
//        rangeSlider.maxValue = 5000
//        rangeSlider.lowerValue = Float(AppDelegate.shared.selectedValuesMin)
//        rangeSlider.upperValue = Float(AppDelegate.shared.selectedValuesMax)
        
        lblLeftMin.isHidden  = true
        lblRightMax.isHidden = true
        lblPrice.isHidden    = true
        viewSlider.isHidden  = true
        tblRow.isHidden      = true
//        rangeSlider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
//        viewSlider.addSubview(rangeSlider)

        tblRow.register(UINib(nibName: "ExpandableCellFilter", bundle: nil), forCellReuseIdentifier: "ExpandableCellFilter")
        tableView.register(UINib(nibName: "ExpandableCellFilter", bundle: nil), forCellReuseIdentifier: "ExpandableCellFilter")
//        rangeSlider.minValue = Float(AppDelegate.shared.selectedValuesMin)
//        rangeSlider.upperValue = Float(AppDelegate.shared.selectedValuesMax)
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
    


    func setupRangeSlider() {
        let savedMin = Float(AppDelegate.shared.selectedValuesMin)
        let savedMax = Float(AppDelegate.shared.selectedValuesMax)

        // Ensure min <= max and clamp accordingly
        let minLimit: Float = 0
        let maxLimit: Float = 5000
        let lower = max(min(savedMin, maxLimit), minLimit)
        let upper = max(min(savedMax, maxLimit), lower)

        let rangeSlider = RangeSliderView(
            frame: CGRect(x: 0, y: 0,
                          width: viewSlider.bounds.width,
                          height: 20)
        )
        rangeSlider.minValue = minLimit
        rangeSlider.maxValue = maxLimit
        rangeSlider.lowerValue = lower
        rangeSlider.upperValue = upper
        rangeSlider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)

        viewSlider.subviews.forEach { $0.removeFromSuperview() }
        viewSlider.addSubview(rangeSlider)

        // Update labels/texts to match
        lblLeftMin.text = "Min : \(Int(lower))"
        lblRightMax.text = "Max : \(Int(upper))"
        minPrice = "\(Int(lower))"
        maxPrice = "\(Int(upper))"

        lblLeftMin.isHidden = false
        lblRightMax.isHidden = false
        lblPrice.isHidden = false
        viewSlider.isHidden = false
    }

    
    private func applyStyle() {
        self.btnproductcount?.titleLabel?.font = UIFont(name: ConstantFontSize.regular, size: 16)
        self.btnproductcount?.titleLabel?.textColor = .black

        self.btnCleanall?.titleLabel?.font = UIFont(name: ConstantFontSize.Bold, size: 18)
        self.btnCleanall?.titleLabel?.textColor = .orange
        
        self.btnApplyFilter?.titleLabel?.font = UIFont(name: ConstantFontSize.regular, size: 14)
        self.btnApplyFilter?.titleLabel?.textColor = .orange
      
        self.btnclosedFilter?.titleLabel?.font = UIFont(name: ConstantFontSize.regular, size: 14)
        self.btnclosedFilter?.titleLabel?.textColor = .black
    
      }
    @objc func sliderChanged(_ sender: RangeSliderView) {
        print("Start: \(Int(sender.lowerValue)), End: \(Int(sender.upperValue))")
        self.lblLeftMin.text  = "Min : \(Int(sender.lowerValue))"
        self.minPrice = "\(Int(sender.lowerValue))"
        AppDelegate.shared.selectedValuesMin = Int(sender.lowerValue)
        self.lblRightMax.text = "Max : \(Int(sender.upperValue))"
        AppDelegate.shared.selectedValuesMax = Int(sender.upperValue)

        self.maxPrice = "\(Int(sender.upperValue))"

}
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let x = Int(round(sender.value))
        lblSliderValue.text = "\(x)"
        lblSliderValue.center = setUISliderThumbValueWithLabel(slider: sender)
    }

    func setUISliderThumbValueWithLabel(slider: UISlider) -> CGPoint {
        let sliderTrack: CGRect = slider.trackRect(forBounds: slider.bounds)
        let sliderFrm: CGRect = slider.thumbRect(forBounds: slider.bounds, trackRect: sliderTrack, value: slider.value)
        return CGPoint(x: sliderFrm.origin.x + slider.frame.origin.x + 12, y: slider.frame.origin.y + 25)
    }

    @IBAction func actBack(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actApply(_ sender: Any) {
        var queryItems: [String] = []
        for (attribute, selectedSet) in AppDelegate.shared.selectedValuesByAttribute {
            let key = attribute.lowercased()
            let valuesString = selectedSet.joined(separator: ",")
            if valuesString == "" {
                
            } else {
                let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? key
                let encodedValue = valuesString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? valuesString
                queryItems.append("\(encodedKey)=\(encodedValue)")
            }
          
        }

        let finalQuery = queryItems.joined(separator: "&")
        print(finalQuery)
        onStringSelected?(finalQuery,Double(minPrice) ?? 0,Double(maxPrice) ?? 5000)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func actCleanAll(_ sender: Any) {
        AppDelegate.shared.selectedValuesByAttribute = [:]  // if you're mirroring to shared state
        AppDelegate.shared.selectedValuesMin = 0
        AppDelegate.shared.selectedValuesMax = 5000
//           // 2️⃣ Optionally reset UI state:
//           tblRow.isHidden = true
//           viewSlider.isHidden = true
        
        self.navigationController?.popViewController(animated: true)

    }
}

extension LMFilterVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblRow {
            return viewmodel.model?.results[0].attributes[tempIndex].values.count ?? 0 //itemsMaterialtemp.count
        } else {
            return (viewmodel.model?.results[0].attributes.count ?? 0) + 1
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 44
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if tableView == tblRow {
            let cell = tblRow.dequeueReusableCell(withIdentifier: "ExpandableCellFilter", for: indexPath) as! ExpandableCellFilter
            cell.backgroundColor = .clear
            cell.lblName?.backgroundColor = .clear
            //= viewmodel.model?.results[0].attributes[tempIndex].values[indexPath.row]
           cell.lblNameRow?.text  = viewmodel.model?.results[0].attributes[tempIndex].values[indexPath.row].firstWordCapitalized

            cell.lblName.isHidden = true
            cell.lblNameRow.isHidden = false
            cell.view.isHidden = false

            // Selection image setup
            let attribute = viewmodel.model?.results[0].attributes[tempIndex]
            let attributeName = attribute?.name.uppercased() ?? ""
            let value = attribute?.values[indexPath.row] ?? ""
            let isSelected = AppDelegate.shared.selectedValuesByAttribute[attributeName]?.contains(value) ?? false
           let imageName = isSelected ? "checkClick" : "square"
            cell.btnSelect.setImage(UIImage(named: imageName), for: .normal)

            // Tag for action
            cell.btnSelect.tag = indexPath.row
            cell.btnSelect.addTarget(self, action: #selector(selectedButton(_:)), for: .touchUpInside)

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableCellFilter", for: indexPath) as! ExpandableCellFilter
            cell.lblName?.backgroundColor = .clear
            cell.backgroundColor = .clear
            
            let extraIndex = viewmodel.model?.results[0].attributes.count ?? 0
            if indexPath.row == extraIndex {
                cell.lblName?.text = "Price"
                cell.lblName.isHidden = false
                cell.lblNameRow.isHidden = true
                cell.view.isHidden = true
                // Apply selection UI if needed
                if selectedIndexPath == indexPath {
                    cell.lblName?.backgroundColor = .white
                    cell.backgroundColor = .white
                }
            } else {
                let obj = viewmodel.model?.results[0].attributes[indexPath.row]
                cell.lblName?.text = obj?.name.firstWordCapitalized
                cell.lblName.isHidden = false
                cell.lblNameRow.isHidden = true
                cell.view.isHidden = true
                if selectedIndexPath == indexPath {
                    cell.lblName?.backgroundColor = .white
                    cell.backgroundColor = .white
                }
            }

            if selectedIndexPath == indexPath {
                cell.lblName?.backgroundColor = .white
                cell.backgroundColor = .white
            } else {
                cell.lblName?.backgroundColor = .clear
                cell.backgroundColor = .clear
            }
            
            return cell}
    }
    @objc func selectedButton(_ sender: UIButton) {
        let row = sender.tag
        guard let attribute = viewmodel.model?.results[0].attributes[tempIndex] else { return }

        let value = attribute.values[row]
        let attributeName = attribute.name.uppercased()

        var selectedSet = AppDelegate.shared.selectedValuesByAttribute[attributeName] ?? Set<String>()
        if selectedSet.contains(value) {
            selectedSet.remove(value)
        } else {
            selectedSet.insert(value)
        }

        AppDelegate.shared.selectedValuesByAttribute[attributeName] = selectedSet

        // Reload only the affected row for smoother UX
        let indexPath = IndexPath(row: row, section: 0)
        tblRow.reloadRows(at: [indexPath], with: .none)

        // Debug
        let selectedValues = Array(selectedSet).joined(separator: ", ")
        print("Selected in \(attributeName): \(selectedValues)")
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblRow {
            // Inside sub-option row
            tblRow.isHidden = false
            viewSlider.isHidden = true
            lblLeftMin.isHidden  = true
            lblRightMax.isHidden = true
            lblPrice.isHidden    = true
//            tempIndex = indexPath.row
//            selectedIndexPath = indexPath
//            tblRow.reloadData()
//            tableView.reloadData()
        } else {
            let extraIndex = viewmodel.model?.results[0].attributes.count ?? 0
            if indexPath.row == extraIndex {
                // PRICE FILTER section selected
                tblRow.isHidden = true
                viewSlider.isHidden = false
                lblLeftMin.isHidden  = false
                lblRightMax.isHidden = false
                lblPrice.isHidden    = false
                selectedIndexPath = indexPath

                tableView.reloadData()

            } else {
                tempIndex = indexPath.row
                selectedIndexPath = indexPath
                tblRow.reloadData()
                tableView.reloadData()

                // Show attribute filter
                tblRow.isHidden     = false
                viewSlider.isHidden = true
                lblLeftMin.isHidden  = true
                lblRightMax.isHidden = true
                lblPrice.isHidden    = true
            }
        }
    }

    
//    @objc func selectedButton(_ sender : UIButton) {
//            print(sender.tag)
//        selectedIndexPath   = IndexPath(row: sender.tag, section: 0)
//        tblRow.reloadData()
//
//
//    }
}

//class CustomSlider: UISlider {
//    override func trackRect(forBounds bounds: CGRect) -> CGRect {
//        let point = CGPoint(x: bounds.minX, y: bounds.midY)
//        return CGRect(origin: point, size: CGSize(width: bounds.width, height: 20))
//    }
//}
class CustomSlider: UISlider {

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 5.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }

}
