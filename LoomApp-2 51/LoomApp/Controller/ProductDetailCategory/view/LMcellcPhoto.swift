//
//  MainCell.swift
//  expandableCellDemo
//
//  Created by Flucent tech on 07/04/25.
//

import UIKit

class LMcellcPhoto : UICollectionViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblline: UILabel!

    class CenterAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }

            // Only modify for horizontal layout (or vertical if needed)
            let sectionInsets = self.sectionInset
            let cellAttributes = attributes.filter { $0.representedElementCategory == .cell }

            // Group by row (only for vertical layout)
            var leftMargin = sectionInsets.left
            var maxY: CGFloat = -1.0
            var rowAttributes: [UICollectionViewLayoutAttributes] = []

            for layoutAttribute in cellAttributes {
                if layoutAttribute.frame.origin.y >= maxY {
                    centerRowCells(rowAttributes, collectionViewWidth: collectionView?.bounds.width ?? 0, sectionInset: sectionInsets)
                    rowAttributes.removeAll()
                    maxY = layoutAttribute.frame.maxY
                }
                rowAttributes.append(layoutAttribute)
            }

            centerRowCells(rowAttributes, collectionViewWidth: collectionView?.bounds.width ?? 0, sectionInset: sectionInsets)
            return attributes
        }

        private func centerRowCells(_ rowAttributes: [UICollectionViewLayoutAttributes], collectionViewWidth: CGFloat, sectionInset: UIEdgeInsets) {
            let totalWidth = rowAttributes.reduce(0) { $0 + $1.frame.width } +
                CGFloat(rowAttributes.count - 1) * minimumInteritemSpacing

            let leftPadding = (collectionViewWidth - totalWidth - sectionInset.left - sectionInset.right) / 2
            var offset = sectionInset.left + max(leftPadding, 0)

            for attributes in rowAttributes {
                attributes.frame.origin.x = offset
                offset += attributes.frame.width + minimumInteritemSpacing
            }
        }
    }

    // Note: must be strong
    @IBOutlet private var maxWidthConstraint: NSLayoutConstraint! {
        didSet {
            maxWidthConstraint.isActive = false
        }
    }
    
    var maxWidth: CGFloat? = nil {
        didSet {
            guard let maxWidth = maxWidth else {
                return
            }
            maxWidthConstraint.isActive = true
            maxWidthConstraint.constant = maxWidth
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
}

class LMcellcPhoto1 : UICollectionViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var viewCell: UIView!


    // Note: must be strong
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
