
import UIKit

@objc protocol InteractiveLabelDelegate: class {
    func interactiveLabel(_ interactiveLabel:InteractiveLabel, didDetectTapWithSender sender: UITapGestureRecognizer)
}

class InteractiveLabel: UILabel {
    
    @IBOutlet weak open var delegate: AnyObject?
    private var tapper: UITapGestureRecognizer!
    
    @IBInspectable var allowTap: Bool = false {
        didSet {
            if allowTap {
                if !(gestureRecognizers?.contains(tapper) ?? false) {
                    self.addGestureRecognizer(tapper)
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        tapper = UITapGestureRecognizer(target: self, action: #selector(tapperDidTap(sender:)))
        isUserInteractionEnabled = true
    }
    
    @objc func tapperDidTap(sender: UITapGestureRecognizer) {
        (delegate as? InteractiveLabelDelegate)?.interactiveLabel(self, didDetectTapWithSender: sender)
    }
}
