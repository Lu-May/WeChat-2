//
//  ImageCache.swift
//  WeChat-2
//
//  Created by Yuehuan Lu on 2021/2/17.
//

import Foundation
import UIKit

class ImageCache {
  static let shared = ImageCache()
  
  private let imageNetworkClient: netWorkClient = .init()
  
  func getImageFromCache(_ url: String, completion: @escaping (UIImage) -> Void) {
    if let image = MemoryCache.shared.getImage(url: url) {//哈希算法 尽量不可读
      completion(image)
    } else if let image = DiskCache.shared.getImage(url: url) {
      MemoryCache.shared.saveImage(url: url, image: image)
      completion(image)
    } else {
      guard let imageUrl = URL(string: url) else {
        return
      }
      
      imageNetworkClient.request(url: imageUrl) { data,_  in
        if let data = data {
          MemoryCache.shared.saveImage(url: url, image: UIImage(data: data)!)
          DiskCache.shared.saveImage(url: url, image: UIImage(data: data)!)
          DispatchQueue.main.async {
            completion(UIImage(data: data)!)
          }
        }
      }
    }
  }
}
