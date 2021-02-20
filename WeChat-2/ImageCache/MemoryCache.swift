//
//  MemoryCache.swift
//  WeChat-2
//
//  Created by Yuehuan Lu on 2021/2/17.
//

import Foundation
import UIKit

class MemoryCache {
  static let shared = MemoryCache()
  var cache = NSCache<NSString, UIImage>()
  
  func getImage(url: String) -> UIImage? {
    return cache.object(forKey: URLService.hash(url: url) as NSString)
  }
  
  func saveImage(url: String, image: UIImage) {
    cache.setObject(image, forKey: URLService.hash(url: url) as NSString)
  }
}
