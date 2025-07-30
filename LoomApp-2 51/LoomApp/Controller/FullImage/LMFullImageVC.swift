import UIKit
import SDWebImage

class LMFullImageVC: UIViewController {
    var imgUrl = ""

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.minimumZoomScale = 1.0
        sv.maximumZoomScale = 4.0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private let closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("✕", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        btn.tintColor = .white
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        btn.layer.cornerRadius = 25
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.addSubview(imageView)
        view.addSubview(closeButton)

        setupConstraints()
        setupGestures()

        if let url = URL(string: imgUrl) {
            imageView.sd_setImage(with: url)
        }

        closeButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
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
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            imageView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor),

            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    private func setupGestures() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }

    @objc private func dismissSelf() {
        dismiss(animated: true)
    }

    @objc private func handleDoubleTap(_ g: UITapGestureRecognizer) {
        let point = g.location(in: imageView)
        let newScale = scrollView.zoomScale == scrollView.minimumZoomScale
            ? scrollView.maximumZoomScale : scrollView.minimumZoomScale

        let w = scrollView.bounds.width / newScale
        let h = scrollView.bounds.height / newScale
        let x = point.x - w / 2
        let y = point.y - h / 2
        scrollView.zoom(to: CGRect(x: x, y: y, width: w, height: h), animated: true)
    }
}

extension LMFullImageVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let boundsSize = scrollView.bounds.size
        let imgSize = imageView.frame.size
        let insetH = imgSize.height < boundsSize.height ? (boundsSize.height - imgSize.height) / 2 : 0
        let insetW = imgSize.width < boundsSize.width ? (boundsSize.width - imgSize.width) / 2 : 0
        scrollView.contentInset = UIEdgeInsets(top: insetH, left: insetW, bottom: insetH, right: insetW)
    }
}
