//
//  UIImageView+Network.swift
//  WeChat-2
//
//  Created by Yuehuan Lu on 2021/2/17.
//

import UIKit

extension UIImageView {
  func setImage(withURL url: String) {
    ImageCache.shared.getImageFromCache(url) { image in
      self.image = image
    }
  }
}
