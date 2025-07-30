//
//  ViewController.swift
//  review
//
//  Created by Flucent tech on 16/06/25.
//

import UIKit
import PhotosUI
import Alamofire
import LiteStarView
import SDWebImage
import Cosmos
import Cosmos


class LMReviewRateVC1: UIViewController  , UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, PHPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //lazy private var viewmodel = LMReviewMV(hostController: self)

   lazy fileprivate var viewmodel = LMReviewRate1MV(hostController: self)

    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var lblMain: UILabel!
    @IBOutlet weak var viewUpload: UIView!
    
    @IBOutlet weak var txtview: UITextView!
    
    
    @IBOutlet weak var tblReview: UITableView!
    var imagesArray: [String]?  = []

    var productId:String = ""
    var variantId:String = ""
    var orderId:String = ""
    var orderItemId:String = ""
    @IBOutlet weak var starView1: StarView!

var imgURL:String = ""
var productName:String = ""

//let productImageView = UIImageView()
//let productTitleLabel = UILabel()
let starRatingView = StarRatingView()
//let addPhotoButton = UIButton(type: .system)
//let galleryButton = UIButton(type: .system)
//let reviewTextView = UITextView()
var photoCollectionView: UICollectionView!
var selectedImages: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        viewEmpty.isHidden = false
        
        
        view.backgroundColor = .white
        viewUpload.layer.borderColor = UIColor.lightGray.cgColor
        viewUpload.layer.borderWidth = 1
        viewUpload.layer.cornerRadius = 0
        txtview.layer.borderColor = UIColor.lightGray.cgColor
        txtview.layer.borderWidth = 1
        txtview.layer.cornerRadius = 0
        txtview.font = UIFont(name: ConstantFontSize.regular, size: 15)
        txtview.text = "How is the product? What do you like? What do you hate?"
        txtview.textColor = .lightGray
        txtview.delegate = self
        txtview.translatesAutoresizingMaskIntoConstraints = false
       // tblReview.register(UINib(nibName: "LMOrderCellReview", bundle: nil), forCellReuseIdentifier: "LMOrderCellReview")

//        tblReview.register(UINib(nibName: "LMReviewCell", bundle: nil), forCellReuseIdentifier: "LMReviewCell")

    
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
        viewmodel.validateValueOrderList()

    }
// MARK: - UI Setup Methods

    @IBAction func actUpload(_ sender: Any) {
        
    }
    @IBAction func actBack(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)

    }
    
//@objc private func closeTapped() {
//    self.navigationController?.popViewController(animated: true)
//}


//private func setupAddPhotoSection() {
//    let titleLabel = UILabel()
//    titleLabel.text = "Add Photo"
//    titleLabel.font = UIFont(name: ConstantFontSize.Bold, size: 16)
//    titleLabel.translatesAutoresizingMaskIntoConstraints = false
//
//    styleAddPhotoButton(addPhotoButton, title: "Add Photo", imageName: "camera")
//    styleAddPhotoButton(galleryButton, title: "Gallery", imageName: "photo")
//
//    addPhotoButton.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
//    galleryButton.addTarget(self, action: #selector(openGallery), for: .touchUpInside)
//
//    let buttonStack = UIStackView(arrangedSubviews: [addPhotoButton, galleryButton])
//    buttonStack.axis = .horizontal
//    buttonStack.spacing = 12
//    buttonStack.distribution = .fillEqually  // Ensure equal width
//    buttonStack.translatesAutoresizingMaskIntoConstraints = false
//
//    let noteLabel = UILabel()
//    noteLabel.text = "Upload photos/videos related to the product like Unboxing, Installation, Product Usage, etc."
//    noteLabel.numberOfLines = 0
//    noteLabel.font = UIFont(name: ConstantFontSize.regular, size: 13)
//    noteLabel.textColor = .darkGray
//    noteLabel.translatesAutoresizingMaskIntoConstraints = false
//
//    view.addSubview(titleLabel)
//    view.addSubview(buttonStack)
//    view.addSubview(noteLabel)
//
////    NSLayoutConstraint.activate([
////        titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 24),
////        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
////
////        buttonStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
////        buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
////
////        noteLabel.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 8),
////        noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
////        noteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
////    ])
//    
//    
//    NSLayoutConstraint.activate([
//        titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 24),
//        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//
//        buttonStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
//        buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//        buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//        buttonStack.heightAnchor.constraint(equalToConstant: 44),  // Adjust as needed
//
//        noteLabel.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 14),
//        noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//        noteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//    ])
//
//}

   

//
//private func setupReviewTextView() {
//    reviewTextView.layer.borderColor = UIColor.lightGray.cgColor
//    reviewTextView.layer.borderWidth = 1
//    reviewTextView.layer.cornerRadius = 0
//    reviewTextView.font = UIFont(name: ConstantFontSize.regular, size: 15)
//    reviewTextView.text = "How is the product? What do you like? What do you hate?"
//    reviewTextView.textColor = .lightGray
//    reviewTextView.delegate = self
//    reviewTextView.translatesAutoresizingMaskIntoConstraints = false
//
//    let label = UILabel()
//    label.text = "Write a Review"
//    label.font = UIFont(name: ConstantFontSize.Bold, size: 16)
//    label.translatesAutoresizingMaskIntoConstraints = false
//
//    view.addSubview(label)
//    view.addSubview(reviewTextView)
//
//    NSLayoutConstraint.activate([
//        label.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 64),
//        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//
//        reviewTextView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15),
//        reviewTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//        reviewTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//        reviewTextView.heightAnchor.constraint(equalToConstant: 100)
//    ])
//}

//private func setupPhotoCollectionView() {
//    let layout = UICollectionViewFlowLayout()
//    layout.scrollDirection = .horizontal
//    layout.itemSize = CGSize(width: 80, height: 80)
//    layout.minimumLineSpacing = 10
//
//    photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//    photoCollectionView.delegate = self
//    photoCollectionView.dataSource = self
//    photoCollectionView.backgroundColor = .clear
//    photoCollectionView.showsHorizontalScrollIndicator = false
//    photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
//    photoCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
//
//    view.addSubview(photoCollectionView)
//
//    NSLayoutConstraint.activate([
//        photoCollectionView.topAnchor.constraint(equalTo: reviewTextView.bottomAnchor, constant: 16),
//        photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//        photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//        photoCollectionView.heightAnchor.constraint(equalToConstant: 80)
//    ])
//}

    private func setupSkipButton() {
        let button = UIButton(type: .system)
        button.setTitle("Review Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: ConstantFontSize.Bold, size: 18)
        button.layer.backgroundColor = UIColor.black.cgColor

        button.layer.borderWidth = 1
        button.layer.cornerRadius = 0
        button.addTarget(self, action: #selector(ReviewViewController.delegateaddress(_:)), for: .touchUpInside)

        // 👉 Set top/bottom = 10, left/right = 15
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)

        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        var screenSize: CGRect = UIScreen.main.bounds
        let wid = screenSize.width - 20
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 44),
            button.widthAnchor.constraint(equalToConstant: wid)
        ])
        
    }
//    @objc func delegateaddress(_ sender: UIButton) {
//        if starRatingView.rating == 0 {
//            AlertManager.showAlert(on: self,
//                                   title: "",
//                                   message: "Please rate the product") {}
//        } else {
//            if (imagesArray?.count ?? 0) > 2 {
//                AlertManager.showAlert(on: self,
//                                       title: "",
//                                       message: "You can upload up to 2 images only") {}
//            } else {
////                self.viewmodel.validateValueReview(
////                    productId: productId,
////                    OrderId: orderId,
////                    OrderItemId: orderItemId,
////                    comment: reviewTextView.text,
////                    variantId: variantId,
////                    rating1: starRatingView.rating,
////                    images: imagesArray ?? []
////                )
//            }
//        }
//    }

// MARK: - Picker Actions

//@objc private func openCamera() {
//    guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
//    let picker = UIImagePickerController()
//    picker.sourceType = .camera
//    picker.delegate = self
//    present(picker, animated: true)
//}
//
//@objc private func openGallery() {
//    var config = PHPickerConfiguration()
//    config.selectionLimit = 5
//    config.filter = .images
//    let picker = PHPickerViewController(configuration: config)
//    picker.delegate = self
//    present(picker, animated: true)
//}

// MARK: - Delegates

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        
        if results.count > 2 {
            AlertManager.showAlert(on: self,
                                   title: "",
                                   message: "You can upload up to 2 images only") {}
        } else {
            let allowedCount = 2
            let limitedResults = results.prefix(allowedCount)
           
            for result in limitedResults {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                    guard let self = self else { return }

                    if let image = object as? UIImage {
                        DispatchQueue.main.async {
                            if self.selectedImages.count < allowedCount {
                                self.selectedImages.append(image)
                                self.photoCollectionView.reloadData()

                                guard let imgData = image.jpegData(compressionQuality: 0.75) else { return }
//                                self.viewmodel.compressDataToUpload.append(imgData)
//                                self.viewmodel.filenameArray.append("upload.jpg")
//                                self.viewmodel.image = image
//
//                                GlobalLoader.shared.show()
//
//                                self.viewmodel.uploadImageToServer(image: image) { result in
//                                    GlobalLoader.shared.hide()
//                                    switch result {
//                                    case .success(let url):
//                                        self.imagesArray?.append(url)
//                                        print("✅ Uploaded: \(url)")
//                                    case .failure(let err):
//                                        print("❌ Upload failed: \(err)")
//                                    }
//                                }
                            }
                        }
                    }
                }
            }
        }
        
        
        
        
       
    }


func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true)
    if let image = info[.originalImage] as? UIImage {
        selectedImages.append(image)
        photoCollectionView.reloadData()
    }
}

func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true)
}

    @IBAction func actShop(_ sender: Any) {
        self.NavigationController(navigateFrom: self, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return selectedImages.count
}

//func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
//    cell.imageView.image = selectedImages[indexPath.item]
//    return cell
//}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.imageView.image = selectedImages[indexPath.item]

        // Remove action
        cell.onRemove = { [weak self] in
            guard let self = self else { return }
            self.selectedImages.remove(at: indexPath.item)
            self.imagesArray?.remove(at: indexPath.item)
            self.photoCollectionView.reloadData()
        }

        return cell
    }

func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == .lightGray {
        textView.text = nil
        textView.textColor = .black
    }
}

func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
        textView.text = "How is the product? What do you like? What do you hate?"
        textView.textColor = .lightGray
    }
}
    
    @IBAction func actSubmit(_ sender: Any) {
        editView.isHidden = true

    }
    @objc func editViewAct() {
        editView.isHidden = false
    }
  
}

extension LMReviewRateVC1: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewmodel.model12.count
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewmodel.model12.count
//    }
    
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return viewmodel.model12.count
//    }
    
    @objc func EditReview(_ sender : UIButton) {
        let tag = sender.tag
        let obj = viewmodel.model12[tag]

        let vc = ReviewViewController()
        vc.imgURL      = obj.image ?? ""
        vc.productName = obj.title ?? ""
        vc.comment = obj.review?.comment ?? ""
        vc.images = obj.review?.images
        vc.rateing = Int(obj.review?.rating ?? 0)
        vc.imagesArray = obj.review?.images

        
        vc.flag = "Rate"

        
        vc.productId   = obj.productId ?? ""
        vc.variantId   = obj.variantId ?? ""
        vc.orderId     = obj.orderId ?? ""
        vc.orderItemId = obj.orderItemId ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblReview.dequeueReusableCell(withIdentifier: "LMOrderCellReview", for: indexPath) as! LMOrderCellReview
        cell.selectionStyle = .none
       // cell.btnEdit.addTarget(self, action: #selector(editViewAct), for: .touchUpInside)
        let objModel = viewmodel.model12[indexPath.row]
        cell.imgUser.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgUser.sd_setImage(with: URL(string: objModel.image ?? ""))
        cell.lblcomment.text = objModel.title
        cell.btnCLick.tag = indexPath.row
        cell.btnEdit.tag = indexPath.row
        cell.delegate = self


        if objModel.review == nil {
           // cell.btnCLick.addTarget(self, action: #selector(LMReviewRateVC1.EditReview(_:)), for: .touchUpInside)
            cell.btnCLick.isHidden = true
            cell.btnEdit.isHidden = true
            cell.imgEdit.isHidden = true
            //cell.cosmosViewHalf.isUserInteractionEnabled = true
           // cell.viewStar.rating = 0
                cell.cosmosViewHalf.rating = 0

        } else {
            cell.btnCLick.isHidden = false
            cell.btnEdit.addTarget(self, action: #selector(LMReviewRateVC1.EditReview(_:)), for: .touchUpInside)
            cell.btnEdit.isHidden = false
            cell.imgEdit.isHidden = false
            //cell.cosmosViewHalf.isUserInteractionEnabled = false
//            cell.viewStar.rating = CGFloat(Int(objModel.review?.rating ?? 0))
            cell.cosmosViewHalf.rating = Double(Int(objModel.review?.rating ?? 0))

//
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
                return 130

            
    }
    

  

}

extension LMReviewRateVC1: LMOrderCellReviewDelegate {
   
    
    func didTapStarInCell(_ cell: LMOrderCellReview, value: Int) {
        guard let indexPath = tblReview.indexPath(for: cell) else { return }

        let obj = viewmodel.model12[indexPath.row]

        let vc = ReviewViewController()
        vc.imgURL      = obj.image ?? ""
        vc.productName = obj.title ?? ""
        vc.comment = obj.review?.comment ?? ""
        vc.images = obj.review?.images
        vc.rateing = Int(value)
        vc.imagesArray = obj.review?.images

        
        vc.flag = "Rate"

        
        vc.productId   = obj.productId ?? ""
        vc.variantId   = obj.variantId ?? ""
        vc.orderId     = obj.orderId ?? ""
        vc.orderItemId = obj.orderItemId ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
}

protocol LMOrderCellReviewDelegate: AnyObject {
    func didTapStarInCell(_ cell: LMOrderCellReview, value: Int) // Replace `Any` with your actual type
}
class LMOrderCellReview: UITableViewCell {
    weak var delegate: LMOrderCellReviewDelegate?

    @IBOutlet weak var imgEdit: UIImageView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var viewRating: UIView!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var viewStar: StarView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnCLick: UIButton!
    @IBOutlet weak var cosmosViewHalf: CosmosView!

    @IBOutlet weak var lblcomment: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    cosmosViewHalf.didTouchCosmos = didTouchCosmos
        
       // viewMain.addBottomBorderWithShadow()
    }
    private func didTouchCosmos(_ rating: Double) {
        print("rating==\(rating)")
        delegate?.didTapStarInCell(self, value: Int(rating))

    }
    
    private func didFinishTouchingCosmos(_ rating: Double) {
        print("ratingrating==\(rating)")

    }
    
    // Your code here
}



//{
//    
//    
//        if viewmodel.modelReview.count == 1 {
//            let obj = viewmodel.modelReview[0]
//            if obj.images?[0].count == 0 {
//                return 250
//            }
//            return 400
//
//        } else if viewmodel.modelReview.count == 2 || viewmodel.modelReview.count >= 2{
//            let obj = viewmodel.modelReview[0]
//            if obj.images?.count != 0 {
//                if obj.images?[0].count != 0 {
//                        
//                        
//                let obj1 = viewmodel.modelReview[1]
//                    if obj1.images?.count != 0 {
//
//                        if obj1.images?[1].count != 0 {
//                            return 680
//                        } else {
//                            return 400
//                        }
//                    }
//                }
//                return 400
//            }
//        } else {
//            return 100
//        }
//       
//   
//}
