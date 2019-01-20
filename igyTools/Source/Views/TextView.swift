
import UIKit

public class TextView: UITextView {
  private let placeholderLeftMargin: CGFloat = 4.0
  private let placeholderTopMargin: CGFloat = 8.0
  private lazy var placeholderLabel: UILabel = {
    let label = UILabel()
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.numberOfLines = 0
    label.backgroundColor = UIColor.clear
    label.alpha = 1.0
    
    return label
  }()
  
  @IBInspectable
  public var placeholderColor: UIColor = UIColor.lightGray {
    didSet {
      placeholderLabel.textColor = placeholderColor
    }
  }
  
  @IBInspectable
  public var placeholder: String = "" {
    didSet {
      placeholderLabel.text = placeholder
      placeholderSizeToFit()
    }
  }
  
  public override var font: UIFont? {
    didSet {
      placeholderLabel.font = font
      placeholderSizeToFit()
    }
  }
  
  public override var text: String! {
    didSet {
      textChanged(nil)
    }
  }
  
  private func placeholderSizeToFit() {
    placeholderLabel.frame = CGRect(
      x: placeholderLeftMargin,
      y: placeholderTopMargin,
      width: frame.width - placeholderLeftMargin * 2,
      height: 0.0
    )
    placeholderLabel.sizeToFit()
  }
  
  private func setup() {
    contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0);
    placeholderLabel.font = self.font
    placeholderLabel.textColor = placeholderColor
    placeholderLabel.text = placeholder
    placeholderSizeToFit()
    addSubview(placeholderLabel)
    
    sendSubviewToBack(placeholderLabel)
    
    let center = NotificationCenter.default
    center.addObserver(
      self,
      selector: #selector(TextView.textChanged(_:)),
      name: UITextView.textDidChangeNotification,
      object: nil
    )
    
    textChanged(nil)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  public override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    setup()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  @objc public func textChanged(_ notification:Notification?) {
    placeholderLabel.alpha = text.isEmpty ? 1.0 : 0.0
  }
}
