
import UIKit

//class AvatarView: NibLoadingView {
//    @IBOutlet weak var imageView: InteractiveImageView!
//    @IBOutlet weak var avatarView: UIView!
//    @IBOutlet weak var label: UILabel!
//    
//    var image: UIImage? {
//        get {
//            return imageView.image
//        } set {
//            avatarView.isHidden = newValue != nil
//            
//            if let image = newValue {
//                imageView.setImage(image: image)
//            }
//        }
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        avatarView.layer.cornerRadius = self.frame.size.height / 2
//        imageView.layer.cornerRadius = self.frame.size.height / 2
//    }
//    
//    func update(with user: User) {
//        update(fCh: user.firstName.characters.first, lCh: user.lastName.characters.first, url: user.imageUrl)
//        
//    }
//    
//    func update(with chat: Chat) {
//        let words = chat.title.components(separatedBy: " ").filter { !$0.isEmpty }
//        update(fCh: words.first?.characters.first, lCh: words.last?.characters.first, url: chat.imageUrl)
//        
//    }
//    
//    func update(with title: String, url: String?) {
//        let words = title.components(separatedBy: " ").filter { !$0.isEmpty }
//        update(fCh: words.first?.characters.first, lCh: words.last?.characters.first, url: url)
//    }
//    
//    func update(fCh: Character?, lCh: Character?, url: String?) {
//        avatarView.isHidden = false
//        
//        let fCharackter = String(fCh ?? Character(" "))
//        let lCharackter = String(lCh ?? Character(" "))
//        let str = fCharackter + lCharackter
//        let color = UIColor.random
//        
//        guard !str.isEmpty else {
//            return
//        }
//        
//        label.textColor = color
//        label.font = UIFont.systemFont(ofSize: fontSize)
//        label.text = str.uppercased()
//        
//        guard url != nil else { return }
//        
//        imageView.setImage(fromImageUrlString: url ?? kEmptyStringValue, completion: { loadedImage -> Bool in
//            self.avatarView.isHidden = true
//            
//            return loadedImage?.imageUrl?.absoluteString == url ?? kEmptyStringValue
//        }, skipConfirmanceCompletion: {
//            self.avatarView.isHidden = false
//        })
//    }
//    
//    fileprivate var fontSize: CGFloat {
//        return min(bounds.width, bounds.height) * 2 / 5
//    }
//}
