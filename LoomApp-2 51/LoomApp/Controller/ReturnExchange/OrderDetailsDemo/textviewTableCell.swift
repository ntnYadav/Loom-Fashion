//
//  textviewTableCell.swift
//  OrderDetailsDemo
//
//  Created by Abdul Quadir on 10/07/25.
//

import UIKit

class textviewTableCell: UITableViewCell,UITextViewDelegate {

    
    @IBOutlet weak var textview: UITextView!
    let placeholder = "   Other reason or any comment..."
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
            textview.delegate = self
            textview.isEditable = true
            textview.isSelectable = true
            textview.isScrollEnabled = false
            textview.textColor = .lightGray
            textview.text = placeholder
        
        // Add border
           textview.layer.borderWidth = 1.0
           textview.layer.borderColor = UIColor.lightGray.cgColor
           textview.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
          if textView.text == placeholder {
              textView.text = ""
              textView.textColor = .black
          }
      }
    
    func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                textView.text = placeholder
                textView.textColor = .lightGray
            }
        }
}
