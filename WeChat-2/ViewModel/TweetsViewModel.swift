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
  var profile: Profile?
  
  private let jsonDatasNetworkClient: netWorkClient = .init()
  
  func getTweetDatas(completion: @escaping () -> Void) {
    jsonDatasNetworkClient.request(url: URL(string: BaseUrl.baseUrl + "moments.json")!) { data, _ in
      guard let data = data else {
        return
      }
      do {
        self.tweetDatas = try JSONDecoder().decode([Tweet].self, from: data)
        self.tweetDatas = self.tweetDatas.filter( { $0.images != nil || $0.content != nil } )
      } catch {
        print(error)
      }
      completion()
    }
  }
  
  func getProfile(completion: @escaping () -> Void) {
    jsonDatasNetworkClient.request(url: URL(string: BaseUrl.baseUrl + "user/jsmith.json")!) { data, _ in
      guard let data = data else {
        return
      }
      do {
        self.profile = try JSONDecoder().decode(Profile.self, from: data)
      } catch {
        print(error)
      }
      completion()
    }
  }
}
