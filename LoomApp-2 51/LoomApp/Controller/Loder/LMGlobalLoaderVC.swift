import UIKit

class GlobalLoader {
    
    static let shared = GlobalLoader()
    
    private var backgroundView: UIView?
    private var activityIndicator: UIActivityIndicatorView?
    
    private init() {}
    
    func show() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
            // Avoid multiple loaders
            if self.backgroundView != nil { return }
            
            let bgView = UIView(frame: window.bounds)
            bgView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.color = .white
            spinner.center = bgView.center
            spinner.startAnimating()
            
            bgView.addSubview(spinner)
            window.addSubview(bgView)
            
            self.backgroundView = bgView
            self.activityIndicator = spinner
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
            self.backgroundView?.removeFromSuperview()
            self.activityIndicator = nil
            self.backgroundView = nil
        }
    }
}
