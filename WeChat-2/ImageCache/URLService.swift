//
//  URLService.swift
//  WeChat-2
//
//  Created by Yuehuan Lu on 2021/2/20.
//

import Foundation

class URLService {
  static func hash(url: String) -> String {
      var result = UInt64 (5381)
      let buf = [UInt8](url.utf8)
      for b in buf {
          result = 127 * (result & 0x00ffffffffffffff) + UInt64(b)
      }
    return String(result)
  }
}
