//
//  NetworkClient.swift
//  WeChat-2
//
//  Created by Yuehuan Lu on 2021/2/5.
//

import Foundation
import Alamofire

struct JsonDatasNetWorkClient {
  func request(url: URL, completion: @escaping (Any?, Error?) -> Void) {
    AF.request(url).validate().responseJSON { dataResponse in
      switch dataResponse.result {
      case .success(_):
        completion(dataResponse.data, nil)
      case let .failure(error):
        completion(nil, error)
      }
    }
  }
}
