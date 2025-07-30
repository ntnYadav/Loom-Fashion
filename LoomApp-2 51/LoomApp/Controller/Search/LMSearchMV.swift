import Foundation
import UIKit
import Toast_Swift

class LMSearchMV: NSObject {
    
    private var hostVC: LMSearchVC
    init(hostController: LMSearchVC) {
        self.hostVC = hostController
    }

    var model: ProductListDataSearch?
    var currentPage = 1
    var totalPages = 1
    var isFetching = false
    var lastQuery = ""

    
    func callWishListAPI(productId: String, strColor: String, strVaiantId: String) {
        GlobalLoader.shared.show()
        let bodyRequest = wishlist(productId: productId, color: strColor.capitalizedFirstLetter, variantId: strVaiantId)
        THApiHandler.post(requestBody: bodyRequest, responseType: WishlistResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error, msg in
            GlobalLoader.shared.hide()
            if dataResponse?.success != true {
                //self?.hostVC.showToastView(message: msg)
            }
        }
    }
    // MARK: - Public Method to Start New Search
    func validateValue(str: String) {
        guard hostVC.checkInternet else { return }

        lastQuery = str
        currentPage = 1
        totalPages = 1
        model = nil
        fetchNextPage()
    }

    // MARK: - Fetch Next Page
    func fetchNextPage() {
        guard hostVC.checkInternet, !isFetching, currentPage <= totalPages else { return }

        isFetching = true
        GlobalLoader.shared.show()

        THApiHandler.getApi(responseType: ProductListResponse.self,
                            page: "\(currentPage)",
                            limit: "10",  // you can change the limit here
                            subcategoryId: lastQuery) { [weak self] dataResponse, error in

            DispatchQueue.main.async {
                GlobalLoader.shared.hide()
                self?.isFetching = false
            }

            guard let self = self else { return }

            if let data = dataResponse?.data {
                self.totalPages = data.totalPages ?? 1

                if self.model == nil {
                    self.model = data
                } else {
                    self.model?.products?.append(contentsOf: data.products ?? [])
                }

                self.currentPage += 1

                DispatchQueue.main.async {
                    let hasResults = (self.model?.products?.isEmpty == false)
                    self.hostVC.collectionView.isHidden = !hasResults
                    self.hostVC.viewEmpty.isHidden = hasResults
//                    if hasResults == true {
//                        self.hostVC.viewEmpty.isHidden = true
//                        self.hostVC.emptylbl1.isHidden = true
//                        self.hostVC.emptyLbl.isHidden = true
//                        self.hostVC.EmptyImage.isHidden = true
//                        self.hostVC.viewEmptyCell.isHidden = true
//                    } else {
//                        self.hostVC.viewEmpty.isHidden = false
//                        self.hostVC.emptylbl1.isHidden = false
//                        self.hostVC.emptyLbl.isHidden = false
//                        self.hostVC.EmptyImage.isHidden = false
//                        self.hostVC.viewEmptyCell.isHidden = false
//                    }
                    
                    self.hostVC.collectionView.reloadData()
                }

            } else {
                DispatchQueue.main.async {
                    self.hostVC.collectionView.isHidden = true
                    self.hostVC.viewEmpty.isHidden = false
                    self.hostVC.emptylbl1.isHidden = false
                    self.hostVC.emptyLbl.isHidden = false
                    self.hostVC.EmptyImage.isHidden = false
                    self.hostVC.viewEmptyCell.isHidden = false
                    
                    self.hostVC.txtSearchBorder.resignFirstResponder() // Hides the keyboard

                }
            }
        }
    }
}
