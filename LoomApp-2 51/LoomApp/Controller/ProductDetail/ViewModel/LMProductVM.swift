import Foundation
import UIKit
import Toast_Swift

class LMProductVM: NSObject {
    
    var model: productData?
    var allProducts: [product] = [] // ✅ Matches model's type

    private var currentPage = 1
    private var totalPages = 1
    private var isLoading = false
    
    private var hostVC: LMProductDetailVC
    init(hostController: LMProductDetailVC) {
        self.hostVC = hostController
    }

    // MARK: - Product Detail with Pagination
    //2ad
    func getProductCategory(productID: String, strQuery: String, limit: String = "10", page: Int = 1, minPrice: Double ,maxPrice: Double, sorting: String) {
        guard hostVC.checkInternet, !isLoading else { return }
        isLoading = true
        
        if page == 1 {
            allProducts.removeAll()
        }
        
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: ProductResponse.self, idStr: productID, page: "\(page)", limit: limit, subcategoryId: strQuery, tagValue: strQuery, MaxPrice: maxPrice,MinPrice:minPrice, sortBy: sorting) { [weak self] dataResponse, error in
            GlobalLoader.shared.hide()
            self?.isLoading = false
            
            guard let self = self else { return }
            
            if let data = dataResponse?.data {
                self.hostVC.emptyView.isHidden = true
                
                
                if (data.products?.count == 0) {
                  // handle empty product list
                    self.hostVC.emptyView.isHidden = false

                } else {
                    self.model = data
                    self.currentPage = page
                    self.totalPages = data.totalPages ?? 1
                    
                    // Append new products
                    if let products = data.products {
                        self.allProducts.append(contentsOf: products)
                    }

                    DispatchQueue.main.async {
                        self.hostVC.cvCollection.reloadData()
                    }
                }
                

               
            } else {
                self.hostVC.emptyView.isHidden = false
            }
        }
    }
    
    func loadNextPageIfNeeded(currentIndex: Int) {
        guard currentIndex >= allProducts.count - 5, currentPage < totalPages, !isLoading else { return }
        getProductCategory(productID: self.hostVC.productId, strQuery: "", page: currentPage + 1,minPrice: 0, maxPrice:5000, sorting: "")
    }

    // MARK: - Static Product Listing (No Pagination)
    func getProductListing(productID: String, tagValue: String) {
        guard hostVC.checkInternet else { return }
        
        let lowercased = tagValue.lowercased()
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: ProductResponse1.self, idStr: productID, tagValue: lowercased) { [weak self] dataResponse, error in
            GlobalLoader.shared.hide()
            if let data = dataResponse?.data {
                self?.model = data
                DispatchQueue.main.async {
                    self?.hostVC.cvCollection.reloadData()
                }
            }
        }
    }

    // MARK: - Wishlist API
    func callWishListAPI(productId: String, strColor: String, strVaiantId: String) {
        GlobalLoader.shared.show()
        let bodyRequest = wishlist(productId: productId, color: strColor.capitalizedFirstLetter, variantId: strVaiantId)
        THApiHandler.post(requestBody: bodyRequest, responseType: WishlistResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error, msg in
            GlobalLoader.shared.hide()
            if dataResponse?.success != true {
                self?.hostVC.showToastView(message: msg)
            }
        }
    }
}
