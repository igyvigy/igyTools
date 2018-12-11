//
//import UIKit
//
//final class ReusableImageViewCatche {
//    static let current = ReusableImageViewCatche()
//    private init() {}
//    private let isUsingPersistence = true
//    private var _runtimeCatche = [URL: Image]()
//    
//    func imageFor(_ url: URL) -> Image? {
//        if let imageFromCatche = _runtimeCatche[url] {
//            return imageFromCatche
//        } else if isUsingPersistence {
//            if let image = DocumentsHelper.getImageFromCatche(withUrl: url) {
//                _runtimeCatche[url] = image
//                return image
//            } else { return nil }
//        } else { return nil }
//    }
//    
//    func save(_ image: Image?, for url: URL?) {
//        guard let image = image, let url = url else { return }
//        if _runtimeCatche[url] != nil {
//            return
//        } else {
//            _runtimeCatche[url] = image
//            if isUsingPersistence {
//                DispatchQueue.global(qos: .background).async {
//                    DocumentsHelper.saveToImageCatche(image: image, url: url)
//                }
//            }
//        }
//    }
//}
//
//class ReusableImageView: UIImageView {
//    var transitionView: UIView?
//    var spinnerView: UIActivityIndicatorView?
//    var imageLoadCompletion: ((Image?) -> Bool)?
//    var skipConfirmanceCompletion: Completion?
//
//    @IBInspectable var transitionColor: UIColor = UIColor.white {
//        didSet {
//            transitionView?.backgroundColor = transitionColor
//        }
//    }
//    
//    private var _showTransition = false
//    @IBInspectable var showTransition: Bool = false {
//        didSet {
//            _showTransition = showTransition
//        }
//    }
//    private var _showSpinner = false
//    @IBInspectable var showSpinner: Bool = false {
//        didSet {
//            _showSpinner = showSpinner
//        }
//    }
//    
//    open var urlString: String {
//        return imageUrl?.absoluteString ?? firUrl ?? "no_url_string"
//    }
//    
//    private var imageUrl: URL? {
//        didSet {
//            guard let imageUrl = imageUrl else { return }
//            image = nil
//            transitionView?.isHidden = false
//            if let catchedImage = ReusableImageViewCatche.current.imageFor(imageUrl) {
//                self.endUp(with: catchedImage, skipConfirmance: true, for: { [weak self] in
//                    self?.setImage(image: catchedImage, shouldUseTransition: self?._showTransition ?? false)
//                })
//            } else {
//                if _showSpinner {
//                    spinnerView?.isHidden = false
//                    spinnerView?.startAnimating()
//                }
//                reloadImageForWeb() { [weak self] image in
//                    self?.endUp(with: image, for: {
//                        self?.commit(image: image)
//                    })
//                }
//            }
//        }
//    }
//    
//    fileprivate var firUrl: String? {
//        didSet {
//            guard let firUrl = firUrl else { return }
//            image = nil
//            transitionView?.isHidden = false
//            guard let url = URL(string: firUrl) else { return }
//            if let catchedImage = ReusableImageViewCatche.current.imageFor(url) {
//                self.endUp(with: catchedImage, skipConfirmance: true, for: { [weak self] in
//                    self?.setImage(image: catchedImage, shouldUseTransition: self?._showTransition ?? false)
//                })
//            } else {
//                if _showSpinner {
//                    spinnerView?.isHidden = false
//                    spinnerView?.startAnimating()
//                }
//                
//                StorageHelper.loadImage(withUrl: firUrl, completion: { [weak self] image in
//                    self?.endUp(with: image, for: {
//                        self?.commit(image: image)
//                    })
//                })
//            }
//        }
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        if transitionView ==  nil {
//            createTransitionView()
//        }
//        if spinnerView == nil {
//            createSpinner()
//        }
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        if transitionView ==  nil {
//            createTransitionView()
//        }
//        if spinnerView == nil {
//            createSpinner()
//        }
//    }
//    
//    func setImage(image: UIImage) {
//        self.image = image
//        spinnerView?.stopAnimating()
//        spinnerView?.isHidden = true
//        transitionView?.isHidden = true
//    }
//    
//    fileprivate func commit(image: Image?) {
//        ReusableImageViewCatche.current.save(image, for: image?.imageUrl)
//        setImage(image: image, shouldUseTransition: true)
//    }
//    
//    fileprivate func endUp(with image: Image?, skipConfirmance: Bool = false, for block: () -> Void) {
//        if let imageCompletion = imageLoadCompletion {
//            if imageCompletion(image) {
//                block()
//            } else if skipConfirmance {
//                if let skipConfirmanceCompletion = skipConfirmanceCompletion {
//                    skipConfirmanceCompletion()
//                    block()
//                } else {
//                    block()
//                }
//            }
//        } else {
//            block()
//        }
//    }
//    
//    func setImage(fromImageUrlString string: String?, completion: ((Image?) -> Bool)? = nil, skipConfirmanceCompletion: Completion? = nil) {
//        guard let string = string else { return }
//        self.imageLoadCompletion = completion
//        self.skipConfirmanceCompletion = skipConfirmanceCompletion
//        
//        if let imageUrl = URL(string: string) {
//            if string.range(of: kUserUploadsImagesPath) != nil {
//                self.firUrl = string
//            } else if string.range(of: kUserUploadsVideosPath) != nil {
//                self.firUrl = string
//            } else {
//                self.imageUrl = imageUrl
//            }
//        } else {
//            self.firUrl = string
//        }
//    }
//    func setImage(fromFirebaseStorageUrl firUrl: String?, completion: ((Image?) -> Bool)? = nil, skipConfirmanceCompletion: Completion? = nil) {
//        self.imageLoadCompletion = completion
//        self.skipConfirmanceCompletion = skipConfirmanceCompletion
//        self.firUrl = firUrl
//    }
//    private func createTransitionView() {
//        transitionView = UIView(frame: frame)
//        transitionView?.center = center
//        transitionView?.backgroundColor = transitionColor
//        addSubview(withConstraints: transitionView!)
//        bringSubview(toFront: transitionView!)
//    }
//    
//    private func createSpinner() {
//        spinnerView = UIActivityIndicatorView(frame: frame)
//        spinnerView?.center = center
//        spinnerView?.activityIndicatorViewStyle = .gray
//        addSubview(withConstraints: spinnerView!)
//        bringSubview(toFront: spinnerView!)
//        if _showSpinner {
//            spinnerView?.startAnimating()
//        } else {
//            spinnerView?.isHidden = true
//        }
//    }
//    
//    private func reloadImageForWeb(completion: @escaping (Image?) -> Void) {
//        if let url = imageUrl {
//            var data: Data?
//            let workItem = DispatchWorkItem(qos: .userInitiated, flags: [], block: {
//                data = try? Data(contentsOf: url)
//            })
//            DispatchQueue.global().async(execute: workItem)
//            workItem.notify(queue: .main, execute: {
//                if url == self.imageUrl {
//                    if let data = data {
//                        var imageObject: Image?
//                        if let img = UIImage(data: data) {
//                            imageObject = Image(uiImage: img, urlString: url.absoluteString)
//                        }
//                        completion(imageObject)
//                    }
//                }
//            })
//        }
//    }
//   
//    private func setImage(image: Image?, shouldUseTransition: Bool = false) {
//        self.image = image?.image
//        if shouldUseTransition {
//            transitionView?.alpha = 1
//            spinnerView?.stopAnimating()
//            spinnerView?.isHidden = true
//            UIView.animate(withDuration: 0.4, animations: { [weak self] in
//                self?.transitionView?.alpha = 0
//            }) { [weak self] _ in
//                self?.transitionView?.isHidden = true
//            }
//        } else {
//            self.spinnerView?.stopAnimating()
//            self.spinnerView?.isHidden = true
//            self.transitionView?.isHidden = true
//        }
//    }
//    
//    func addSubview(withConstraints subview:UIView) {
//        subview.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(subview)
//        var viewBindingsDict = [String: AnyObject]()
//        viewBindingsDict["subView"] = subview
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|", metrics: nil, views: viewBindingsDict))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|", metrics: nil, views: viewBindingsDict))
//    }
//}
