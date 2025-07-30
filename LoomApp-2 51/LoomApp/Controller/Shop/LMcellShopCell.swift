
//  Created by Flucent tech on 07/04/25.
//

import UIKit

class LMcellShopCell : UICollectionViewCell {
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var lblProductSize: UILabel!
    @IBOutlet weak var imgBackground: UIImageView!
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var lblDiscountPrice: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       // viewMain.addBottomBorderWithShadow()
    }
    
}
