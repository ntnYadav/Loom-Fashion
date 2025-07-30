//
//  ViewController.swift
//  review
//
//  Created by Flucent tech on 16/06/25.
//

import UIKit
import PhotosUI
import Alamofire
class ReviewViewController: UIViewController  , UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, PHPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    lazy private var viewmodel = LMReviewMV(hostController: self)

    var imagesArray: [String]?  = []

    var productId:String = ""
    var variantId:String = ""
    var orderId:String = ""
    var orderItemId:String = ""

    var imgURL:String = ""
    var productName:String = ""
    var flag:String = ""
    var rateing:Int = 0

    var comment:String = ""
    var images: [String]? = nil

    
    
    

let productImageView = UIImageView()
let productTitleLabel = UILabel()
    let starRatingView = StarRatingView()
let addPhotoButton = UIButton(type: .system)
let galleryButton = UIButton(type: .system)
let reviewTextView = UITextView()
var photoCollectionView: UICollectionView!
var selectedImages: [UIImage] = []
var selectedImages1: [String] = []

override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    setupHeader()
    setupProductInfo()
    setupAddPhotoSection()
    setupReviewTextView()
    setupPhotoCollectionView()
    setupSkipButton()
    setupCustomHeader()
    
    productTitleLabel.text = productName
    productImageView.sd_setImage(with: URL(string:imgURL))}
    
    override func viewWillAppear(_ animated: Bool) {
        if flag == "Rate" {
            reviewTextView.text   = comment
            starRatingView.rating = rateing
            
            if let images = images, !images.isEmpty {
                for imageURL in images {
                    print("Image URL: \(imageURL)")
                    selectedImages1.append(imageURL)
                    // Use imageURL (String) to load image, e.g., into UIImageView
                }
            }
            photoCollectionView.isHidden = false
            photoCollectionView.reloadData()
        }
    }

// MARK: - UI Setup Methods
    private func setupCustomHeader() {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = UIColor.white

        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        closeButton.tintColor = .black
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)

        let titleLabel = UILabel()
        titleLabel.text = "Rate & Review"
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: ConstantFontSize.regular, size: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(headerView)
        headerView.addSubview(closeButton)
        headerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100),

            closeButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            closeButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12),

            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
        ])
    }
private func setupHeader() {
    title = "Review Product"
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeTapped))
}

@objc private func closeTapped() {
    self.navigationController?.popViewController(animated: true)
}

private func setupProductInfo() {
    productImageView.translatesAutoresizingMaskIntoConstraints = false
    productImageView.image = UIImage(systemName: "photo")
    productImageView.contentMode = .scaleAspectFill
    productImageView.clipsToBounds = true
    productImageView.layer.cornerRadius = 0

    productTitleLabel.text = "RED TAPE Walking Shoes For Men"
    productTitleLabel.font = UIFont(name: ConstantFontSize.regular, size: 15)
    productTitleLabel.translatesAutoresizingMaskIntoConstraints = false

    starRatingView.translatesAutoresizingMaskIntoConstraints = false
      // starRatingView.setRating(0)

    //ratingStarsLabel.text = "⭐️⭐️⭐️⭐️☆"
   // ratingStarsLabel.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(productImageView)
    view.addSubview(productTitleLabel)
    //view.addSubview(ratingStarsLabel)
    view.addSubview(starRatingView)

    NSLayoutConstraint.activate([
         productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
         productImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
         productImageView.widthAnchor.constraint(equalToConstant: 60),
         productImageView.heightAnchor.constraint(equalToConstant: 80),

         productTitleLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
         productTitleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
         productTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

         starRatingView.topAnchor.constraint(equalTo: productTitleLabel.bottomAnchor, constant: 8),
         starRatingView.leadingAnchor.constraint(equalTo: productTitleLabel.leadingAnchor),
         starRatingView.heightAnchor.constraint(equalToConstant: 40),
         starRatingView.widthAnchor.constraint(equalToConstant: 220) // width for 5 stars + spacing
     ])
    
//    starRatingView.didChangeRating = { [weak self] newRating in
//           print("User selected rating: \(newRating)")
//           // you can update a model or do something with rating here
//       }
}

private func setupAddPhotoSection() {
    let titleLabel = UILabel()
    titleLabel.text = "Add Photo"
    titleLabel.font = UIFont(name: ConstantFontSize.Bold, size: 16)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false

    styleAddPhotoButton(addPhotoButton, title: "Add Photo", imageName: "camera")
    styleAddPhotoButton(galleryButton, title: "Gallery", imageName: "photo")

    addPhotoButton.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
    galleryButton.addTarget(self, action: #selector(openGallery), for: .touchUpInside)

    let buttonStack = UIStackView(arrangedSubviews: [addPhotoButton, galleryButton])
    buttonStack.axis = .horizontal
    buttonStack.spacing = 12
    buttonStack.distribution = .fillEqually  // Ensure equal width
    buttonStack.translatesAutoresizingMaskIntoConstraints = false

    let noteLabel = UILabel()
    noteLabel.text = "Upload photos/videos related to the product like Unboxing, Installation, Product Usage, etc."
    noteLabel.numberOfLines = 0
    noteLabel.font = UIFont(name: ConstantFontSize.regular, size: 13)
    noteLabel.textColor = .darkGray
    noteLabel.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(titleLabel)
    view.addSubview(buttonStack)
    view.addSubview(noteLabel)

//    NSLayoutConstraint.activate([
//        titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 24),
//        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//
//        buttonStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
//        buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//
//        noteLabel.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 8),
//        noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//        noteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//    ])
    
    
    NSLayoutConstraint.activate([
        titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 24),
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

        buttonStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
        buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        buttonStack.heightAnchor.constraint(equalToConstant: 44),  // Adjust as needed

        noteLabel.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 14),
        noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        noteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
    ])

}

    private func styleAddPhotoButton(_ button: UIButton, title: String, imageName: String) {
        button.setTitle(" \(title)", for: .normal)
        button.setImage(UIImage(systemName: imageName), for: .normal)
        
        // Set both image and title color to gray
        button.setTitleColor(.gray, for: .normal)
        button.tintColor = .gray  // This affects the SF Symbol image color

        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 0
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
    }


private func setupReviewTextView() {
    reviewTextView.layer.borderColor = UIColor.lightGray.cgColor
    reviewTextView.layer.borderWidth = 1
    reviewTextView.layer.cornerRadius = 0
    reviewTextView.font = UIFont(name: ConstantFontSize.regular, size: 15)
    reviewTextView.text = "How is the product? What do you like? What do you hate?"
    reviewTextView.textColor = .lightGray
    reviewTextView.delegate = self
    reviewTextView.translatesAutoresizingMaskIntoConstraints = false

    let label = UILabel()
    label.text = "Write a Review"
    label.font = UIFont(name: ConstantFontSize.Bold, size: 16)
    label.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(label)
    view.addSubview(reviewTextView)

    NSLayoutConstraint.activate([
        label.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 64),
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

        reviewTextView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15),
        reviewTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        reviewTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        reviewTextView.heightAnchor.constraint(equalToConstant: 100)
    ])
}

private func setupPhotoCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: 80, height: 80)
    layout.minimumLineSpacing = 10

    photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    photoCollectionView.delegate = self
    photoCollectionView.dataSource = self
    photoCollectionView.backgroundColor = .clear
    photoCollectionView.showsHorizontalScrollIndicator = false
    photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
    photoCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")

    view.addSubview(photoCollectionView)

    NSLayoutConstraint.activate([
        photoCollectionView.topAnchor.constraint(equalTo: reviewTextView.bottomAnchor, constant: 16),
        photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        photoCollectionView.heightAnchor.constraint(equalToConstant: 80)
    ])
}

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
    @objc func delegateaddress(_ sender: UIButton) {
        if starRatingView.rating == 0 {
            AlertManager.showAlert(on: self,
                                   title: "",
                                   message: "Please rate the product") {}
        } else {
            if (imagesArray?.count ?? 0) > 2 {
                AlertManager.showAlert(on: self,
                                       title: "",
                                       message: "You can upload up to 2 images only") {}
            } else {
                self.viewmodel.validateValueReview(
                    productId: productId,
                    OrderId: orderId,
                    OrderItemId: orderItemId,
                    comment: reviewTextView.text,
                    variantId: variantId,
                    rating1: starRatingView.rating,
                    images: imagesArray ?? []
                )
            }
        }
    }

// MARK: - Picker Actions

@objc private func openCamera() {
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
    let picker = UIImagePickerController()
    picker.sourceType = .camera
    picker.delegate = self
    present(picker, animated: true)
}

@objc private func openGallery() {
    var config = PHPickerConfiguration()
    config.selectionLimit = 5
    config.filter = .images
    let picker = PHPickerViewController(configuration: config)
    picker.delegate = self
    present(picker, animated: true)
}

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
                                self.viewmodel.compressDataToUpload.append(imgData)
                                self.viewmodel.filenameArray.append("upload.jpg")
                                self.viewmodel.image = image

                                GlobalLoader.shared.show()

                                self.viewmodel.uploadImageToServer(image: image) { result in
                                    GlobalLoader.shared.hide()
                                    switch result {
                                    case .success(let url):
                                        if self.flag == "Rate" {
                                            self.images?.append(url)
                                        } else {
                                            
                                        }
                                        self.imagesArray?.append(url)
                                        self.photoCollectionView.reloadData()

                                        print("✅ Uploaded: \(url)")
                                    case .failure(let err):
                                        print("❌ Upload failed: \(err)")
                                    }
                                }
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

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if flag == "Rate" {
        return images?.count ?? 0

    } else {
        return selectedImages.count

    }
}

//func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
//    cell.imageView.image = selectedImages[indexPath.item]
//    return cell
//}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        if flag == "Rate" {
            let obj = images?[indexPath.row]
            cell.imageView.sd_setImage(with: URL(string: obj ?? ""))

            // Remove action
            cell.onRemove = { [weak self] in
                guard let self = self else { return }
                self.images?.remove(at: indexPath.item)
                self.imagesArray?.remove(at: indexPath.item)
                self.photoCollectionView.reloadData()
            }
            
        } else {
            cell.imageView.image = selectedImages[indexPath.item]

            // Remove action
            cell.onRemove = { [weak self] in
                guard let self = self else { return }
                self.selectedImages.remove(at: indexPath.item)
                self.imagesArray?.remove(at: indexPath.item)
                self.photoCollectionView.reloadData()
            }
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
}

// MARK: - Custom Photo Cell

class PhotoCell: UICollectionViewCell {
    let imageView = UIImageView()
    let removeButton = UIButton()

    var onRemove: (() -> Void)?  // Callback for removal

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        contentView.addSubview(imageView)

        // Setup remove button
        removeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        removeButton.tintColor = .red
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.addTarget(self, action: #selector(removeTapped), for: .touchUpInside)
        contentView.addSubview(removeButton)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            removeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            removeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            removeButton.widthAnchor.constraint(equalToConstant: 20),
            removeButton.heightAnchor.constraint(equalToConstant: 20)
        ])

        contentView.layer.cornerRadius = 0
        contentView.clipsToBounds = true
    }

    @objc private func removeTapped() {
        onRemove?()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import UIKit
//
//class StarRatingView: UIView {
//    private var starButtons = [UIButton]()
//    private let starCount = 5
//    private(set) var rating = 0
//
//    var didChangeRating: ((Int) -> Void)?
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupStars()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupStars()
//    }
//
//    private func setupStars() {
//        for i in 0..<starCount {
//            let button = UIButton(type: .system)
//            button.tag = i + 1
//            button.setTitle("☆", for: .normal)
//            button.setTitle("★", for: .selected)
//
//            button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
//
//            // Set black color for filled stars
//            button.setTitleColor(.black, for: .selected)
//            // Set a lighter gray color for unfilled stars (optional)
//            button.setTitleColor(.lightGray, for: .normal)
//            button.backgroundColor = .clear
//                    
//                    // Also remove any button tint color that might cause background color or highlight
//                    button.tintColor = .clear
//            button.addTarget(self, action: #selector(starTapped(_:)), for: .touchUpInside)
//            addSubview(button)
//            starButtons.append(button)
//        }
//    }
//
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let buttonSize = bounds.height
//        let spacing: CGFloat = 8
//        for (index, button) in starButtons.enumerated() {
//            let x = CGFloat(index) * (buttonSize + spacing)
//            button.frame = CGRect(x: x, y: 0, width: buttonSize, height: buttonSize)
//        }
//    }
//
//    @objc private func starTapped(_ sender: UIButton) {
//        let selectedRating = sender.tag
//
//        if selectedRating == rating {
//            rating = selectedRating - 1  // unselect if tapped again on same star
//        } else {
//            rating = selectedRating
//        }
//        updateStars()
//        didChangeRating?(rating)
//    }
//
//    private func updateStars() {
//        for button in starButtons {
//            button.isSelected = button.tag <= rating
//        }
//    }
//
//    func setRating(_ newRating: Int) {
//        rating = newRating
//        updateStars()
//    }
//}
class StarRatingView: UIView {
    private var starButtons: [UIButton] = []
    private let starCount = 5
    var rating = 0 {
        didSet {
            updateStarSelection()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStars()
        setupSwipeGestures()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStars()
        setupSwipeGestures()
    }

    private func setupStars() {
        for i in 0..<starCount {
            let button = UIButton(type: .system)
            button.tag = i + 1
            button.setTitle("☆", for: .normal)
            button.setTitle("★", for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
            button.setTitleColor(.black, for: .selected)
            button.setTitleColor(.lightGray, for: .normal)
            button.backgroundColor = .clear
            button.tintColor = .clear

            button.addTarget(self, action: #selector(starTapped(_:)), for: .touchUpInside)
            addSubview(button)
            starButtons.append(button)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonSize = bounds.height
        let spacing: CGFloat = 8
        for (index, button) in starButtons.enumerated() {
            let x = CGFloat(index) * (buttonSize + spacing)
            button.frame = CGRect(x: x, y: 0, width: buttonSize, height: buttonSize)
        }
    }

    @objc private func starTapped(_ sender: UIButton) {
        rating = sender.tag
    }

    private func updateStarSelection() {
        for button in starButtons {
            button.isSelected = button.tag <= rating
        }
    }

    // MARK: - Swipe Gestures

    private func setupSwipeGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        addGestureRecognizer(swipeRight)
    }

    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        let location = gesture.location(in: self)

        // Find star button under swipe location
        for button in starButtons {
            if button.frame.contains(location) {
                if gesture.direction == .left {
                    // Fill stars up to this button
                    rating = button.tag
                } else if gesture.direction == .right {
                    // Unfill stars up to one less than this button
                    rating = button.tag - 1
                    if rating < 0 { rating = 0 }
                }
                break
            }
        }
    }
}
