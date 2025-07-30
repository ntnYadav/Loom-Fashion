//
//  ViewController.swift
//  CustomHeaderView
//
//  Created by Santosh on 04/08/20.
//  Copyright © 2020 Santosh. All rights reserved.
//

import UIKit

class LMShopNow: UIViewController,UISearchBarDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var lblLabel: UILabel!
    @IBOutlet weak var searchborder: UITextField!
    @IBOutlet weak var txtSearchBorder: UITextField!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var tableView: UITableView!
    let  arrRecent = ["RECENT SEARCHES", "TOP SEARCHES", "TRENDING"]
    let  arrList = ["RECENT SEARCHES","RECENT SEARCHES","RECENT SEARCHES","RECENT SEARCHES","RECENT SEARCHES","RECENT SEARCHES","RECENT SEARCHES","RECENT SEARCHES","RECENT SEARCHES"]
    let  arrLast = ["RECENT SEARCHES", "TOP SEARCHES", "TRENDING"]
    let  arrCotegory = ["All", "Shirts", "T-shirts", "Jeans","Trouser", "Jacket","Sweaters","Swearshirt","Shorts","All", "Shirts", "T-shirts", "Jeans","Trouser", "Jacket","Sweaters","Swearshirt","Shorts"]

    var searchBar = UISearchBar()
    let placeholderLabel = UILabel()
    var timer = Timer()
    var counter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarSetup()
        txtSearchBorder.delegate = self //set delegate to textfile
        txtSearchBorder.becomeFirstResponder()

        searchborder.layer.borderWidth = 0.5
        searchborder.layer.borderColor = UIColor.lightGray.cgColor
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeaderView")
        tableView.register(UINib(nibName: "CustomFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomFooterView")
        tableView.register(UINib(nibName: "LMTrendingCell", bundle: nil), forCellReuseIdentifier: "LMTrendingCell")
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField.isFirstResponder {
                let validString = CharacterSet(charactersIn: " !@#$%^&*()_+{}[]|\"<>,.~`/:;?-=\\¥'£•¢₹")

                if (textField.textInputMode?.primaryLanguage == "emoji") || textField.textInputMode?.primaryLanguage == nil {
                    return false
                }
                if let range = string.rangeOfCharacter(from: validString)
                {
                    print(range)
                    return false
                }
            }
            return true
        }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    func searchBarSetup(){}
    @objc func changeImage() {}

    @IBAction func actBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension LMShopNow: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrRecent.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            return 0
       
        case 3:
            return arrList.count
        default:
            return arrList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "LMTrendingCell", for: indexPath) as! LMTrendingCell
        cell.selectionStyle = .none

            tableView.separatorColor = .clear
            // cell.textLabel?.text = arrList[indexPath.row]
            return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderView") as! CustomHeaderView
        //headerView.sectionTitleLabel.text = arrRecent[section]
        self.tableView.separatorColor = .clear

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
  
    
}
