//
//  TweetsViewModel.swift
//  WeChat-2
//
//  Created by Yuehuan Lu on 2021/2/7.
//

import Foundation
import UIKit

class TweetsViewModel {
  var tweetDatas: [Tweet] = []
  
  private let jsonDatasNetworkClient: JsonDatasNetWorkClient = .init()
  
  func getTweetDatas(completion: @escaping () -> Void) {
    jsonDatasNetworkClient.request(url: URL(string: BaseUrl.baseUrl + "moments.json")!) { data, _ in
      do {
        self.tweetDatas = try JSONDecoder().decode([Tweet].self, from: data as! Data)
        self.tweetDatas = self.tweetDatas.filter( { $0.images != nil || $0.content != nil } )
      } catch {
        print(error)
      }
      completion()
    }
  }
}
