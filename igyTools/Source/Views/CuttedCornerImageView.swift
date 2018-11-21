//
//  CuttedCornerImageView.swift
//  Alamofire
//
//  Created by Andrii on 11/16/18.
//

import Foundation

open class CuttedCornerImageView: UIView {
  
  public var imageView: UIImageView?
  public var path: UIBezierPath!
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    initialize()
  }
  
  func initialize() {
    imageView = UIImageView(frame: bounds)
    imageView?.contentMode = .scaleAspectFill
    let cs = ConstraintsSettings(left: 0, right: 0, top: 0, bottom: 0)
    addSubview(imageView!, with: cs)
  }
  
  override open func draw(_ rect: CGRect) {
    let p1 = self.bounds.origin
    let p2 = CGPoint(x: p1.x + bounds.width - 20, y: p1.y)
    let p3 = CGPoint(x: p1.x + bounds.width, y: p1.y + 20)
    let p4 = CGPoint(x: p1.x + bounds.width, y: p1.y + bounds.height)
    let p5 = CGPoint(x: p1.x, y: p1.y + bounds.height)
    
    path = UIBezierPath()
    path.move(to: p1)
    path.addLine(to: p2)
    path.addLine(to: p3)
    path.addLine(to: p4)
    path.addLine(to: p5)
    path.close()
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.frame = bounds
    shapeLayer.path = path.cgPath
    layer.mask = shapeLayer;
    layer.masksToBounds = true;
  }
}
