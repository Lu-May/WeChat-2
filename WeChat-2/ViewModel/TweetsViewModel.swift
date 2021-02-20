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
  var originalDatas: [Tweet] = []
  var tableViewDatas: [Tweet] = []
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
        self.originalDatas = self.tweetDatas
        self.getTableViewDataSource()
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
  
  func initDatas() {
    self.tweetDatas = originalDatas
    tableViewDatas = []
  }
  
  func getTableViewDataSource() {
    if tweetDatas.count / 5 > 0 {
      for var i in 0..<5 {
        i += 1
        tableViewDatas.append(tweetDatas[0])
        tweetDatas.removeFirst()
      }
    } else if tweetDatas.count / 5 == 0 {
      for data in tweetDatas {
        tableViewDatas.append(data)
      }
      tweetDatas = []
    }
  }
}
