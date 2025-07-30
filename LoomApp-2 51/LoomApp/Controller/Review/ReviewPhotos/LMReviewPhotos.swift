//
//  ViewController.swift
//  photos
//
//  Created by Flucent tech on 26/07/25.
//

import UIKit
import SDWebImage

class LMReviewPhotos: UIViewController {

    var customerImages: [String] = []


        // Dummy image names (add these to Assets.xcassets)
        let imageNames = ["imag", "image2", "image3", "image4", "image5", "image6"]

        private let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let spacing: CGFloat = 12
            let itemWidth = (UIScreen.main.bounds.width - (3 * spacing)) / 2
            layout.itemSize = CGSize(width: itemWidth, height: 250)
            layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
            layout.minimumInteritemSpacing = spacing
            layout.minimumLineSpacing = spacing

            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .white
            return collectionView
        }()

        private let headerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()

        private let backButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
            button.tintColor = .black
            return button
        }()

        private let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "CATEGORY IMAGES"
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textAlignment = .center
            label.textColor = .black
            return label
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white

            setupHeader()
            setupCollectionView()
        }

        private func setupHeader() {
            view.addSubview(headerView)
            headerView.translatesAutoresizingMaskIntoConstraints = false

            headerView.addSubview(backButton)
            headerView.addSubview(titleLabel)

            backButton.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                headerView.heightAnchor.constraint(equalToConstant: 44),

                backButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                backButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),

                titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])

            backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        }

        private func setupCollectionView() {
            view.addSubview(collectionView)
            collectionView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        }

        @objc private func didTapBack() {
            dismiss(animated: true)
        }
    }

    // MARK: - CollectionView Delegates
    extension LMReviewPhotos: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return customerImages.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
                return UICollectionViewCell()
            }

            let obj = customerImages[indexPath.item]
            cell.imageView.sd_setImage(with: URL(string: obj))
            //cell.configure(with: UIImage(named: imageName))
            return cell
        }
    }

class ImageCell: UICollectionViewCell {
     let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with image: UIImage?) {
        imageView.image = image
    }
}
