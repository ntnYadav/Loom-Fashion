//
//  ExpandableCell.swift
//  expandableCellDemo
//
//  Created by Itsuki on 2023/10/23.
//

import UIKit

extension ExpandableCell {

    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {

        collectionViewFilter.delegate = dataSourceDelegate
        collectionViewFilter.dataSource = dataSourceDelegate
        collectionViewFilter.tag = row
        collectionViewFilter.setContentOffset(collectionViewFilter.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionViewFilter.reloadData()
    }

    var collectionViewOffset: CGFloat {
        set { collectionViewFilter.contentOffset.x = newValue }
        get { return collectionViewFilter.contentOffset.x }
    }
}
class ExpandableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    static let cellIdentifier = String(describing: ExpandableCell.self)
 //   @IBOutlet weak var label: UILabel!
    var strIndexChek:Int = 0
    var strsection:Int = 0
    
//    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
//        didSet {
//            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        }
//    }
    func setup1(name:String){
      //  self.itemNameLabel.text = name
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    }

    @IBOutlet weak var collectionViewFilter: UICollectionView!
    
    
    func setup(name:String){
      //  self.itemNameLabel.text = name
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
    func setupEverytime(){
        collectionViewFilter.delegate = self
        collectionViewFilter.dataSource = self
        collectionViewFilter.register(UINib(nibName: "LMbagcollectioncell", bundle: nil), forCellWithReuseIdentifier: "LMbagcollectioncell")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    let items: [Item] = [
        Item(title: "  PRICE HIGH TO LOW "),
        Item(title: "  PRICE LOW TO HIGH "),
        Item(title: "  AVG CUSTOMER REVIEW "),
        Item(title: "  Popular           "),
        Item(title: "  New  "),

    ]
    let itemsSize: [Item] = [
        Item(title: " 28 "),
        Item(title: " 30 "),
        Item(title: " 32 "),
        Item(title: " 34 "),
        Item(title: " 36 "),
        Item(title: " 40 "),
        Item(title: " 42 "),
        Item(title: " 44 "),
        Item(title: " 46 "),
        Item(title: " 48 "),
        Item(title: " 50 ")
    ]
    let itemsColor: [Item] = [Item(title: "GRAY"),Item(title: "BLACK"),Item(title: "NAVY"),Item(title: "BEIGE"),Item(title: "BROWN"),Item(title: "CREAM"),Item(title: "GREEN"),Item(title: "OLIVE"),Item(title: "BLUE"),Item(title: "WHITE")
    ]
    let itemsPattern: [Item] = [Item(title: " PLAIN "),Item(title: " SELF-DESIGN "),Item(title: " TEXTURED "),Item(title: " STRIPES "),Item(title: " CHECK ")
    ]
    let itemsFit: [Item] = [Item(title: " SLIM FIT "),Item(title: " RELAXED FIT "),Item(title: " REGULAR FIT ")
    ]
    let itemsMaterial: [Item] = [Item(title: " COTTON "),Item(title: " POLYESTER "),Item(title: " LINEN "),Item(title: " RAYON "),Item(title: " TERRY "), Item(title: " VISCOSE ")
    ]
    var itemsMaterialtemp: [Item] = []
    
    let  arrCotegory = ["All", "Shirts", "T-shirts", "Jeans","Trouser" ]
    var selectedCell = [IndexPath]()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("strIndexChek == \(strIndexChek)")
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 6
        let numberOfItemsPerRow: CGFloat = 3
        
        let totalSpacing = (numberOfItemsPerRow - 1) * spacing
        let width = (collectionView.frame.width - 10) / numberOfItemsPerRow
        return CGSize(width: width, height: 190)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("sectionsection---\(section)")
        return 10
    }
            
            
            
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       // let cell = collectionViewFilter.dequeueReusableCell(withReuseIdentifier: "LMFilterCell", for: indexPath) as! LMFilterCell
        let cell = collectionViewFilter.dequeueReusableCell(withReuseIdentifier: "LMbagcollectioncell", for: indexPath) as! LMbagcollectioncell
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
    
private enum Constants1 {
    static let spacing: CGFloat = 1
    static let borderWidth: CGFloat = 0.5
    static let reuseID = "CollectionCell"
}
