//
//  Untitled.swift
//  LoomApp
//
//  Created by Flucent tech on 03/04/25.
//

import UIKit

class LMPlayVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

        private var collectionView: UICollectionView!

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .black
            setupCollectionView()
            AlertManager.showAlert(on: self,title: "Loom Fashion",
                                                 message: "Under Development") {
                          }
                                   
        }
    override func viewWillAppear(_ animated: Bool) {
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
        private func setupCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 0

            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .white
            collectionView.isPagingEnabled = true
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            //collectionView.isScrollEnabled = false // we will animate manually
            collectionView.showsVerticalScrollIndicator = false
            

            layout.minimumLineSpacing = 0

            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .white
            collectionView.isPagingEnabled = true
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            //collectionView.isScrollEnabled = false // we will animate manually
            collectionView.showsVerticalScrollIndicator = false
            collectionView.delegate = self
            collectionView.dataSource = self

            //collectionView.contentInsetAdjustmentBehavior = .never // ✨ Prevent top inset
            collectionView.register(UINib(nibName: "LMPlaycell", bundle: nil), forCellWithReuseIdentifier: "LMPlaycell")
            view.addSubview(collectionView)

            // Pin edge to edge of the full screen (including under status bar)
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Scroll to the first item without animation
        if collectionView.numberOfItems(inSection: 0) > 0 {
            let indexPath = IndexPath(item: 0, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
        }
    }
        // MARK: - CollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 5
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMPlaycell", for: indexPath) as! LMPlaycell
              cell.setup()
            return cell
        }

        // MARK: - Layout

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let numberOfRowsToShow: CGFloat = 2
            let spacing: CGFloat = 10  // adjust if you use section insets or minimum line spacing
            let totalSpacing = spacing * (numberOfRowsToShow - 1)

//            let itemHeight = (collectionView.bounds.height - totalSpacing) / numberOfRowsToShow
//            layout.itemSize = CGSize(width: collectionView.bounds.width, height: itemHeight)
//            layout.minimumLineSpacing = spacing
            
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
   
}
