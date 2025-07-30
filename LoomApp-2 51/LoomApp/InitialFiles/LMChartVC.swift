import UIKit

import UIKit
import SDWebImage

import UIKit
import SDWebImage

class LMChartVC: UIViewController, UIScrollViewDelegate {


    @IBOutlet weak var imgUrl: UIImageView!
    var sizeChartUrl: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }
    private func loadImage() {
        guard let url = URL(string: sizeChartUrl), !sizeChartUrl.isEmpty else {
            imgUrl.image = UIImage(named: "placeholder")
            return
        }

        imgUrl.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
    }
    
}
