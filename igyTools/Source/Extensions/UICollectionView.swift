//
//  UICollectionView.swift
//  igyTools
//
//  Created by Bohdan Savych on 12/25/18.
//  Copyright © 2018 rolique. All rights reserved.
//

import UIKit

public extension UICollectionView {
  public func setDelegateAndDataSource(_ object: UICollectionViewDelegate & UICollectionViewDataSource) {
    self.delegate = object
    self.dataSource = object
  }
}
