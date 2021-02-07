//
//  Profile.swift
//  WeChat-2
//
//  Created by Yuehuan Lu on 2021/2/7.
//

import Foundation

struct Profile: Codable {
  var profileImage: String
  var avatar: String
  var nick: String
  var username: String
  
  enum CodingKeys: String, CodingKey {
    case profileImage = "profile-image"
    case avatar
    case nick
    case username
  }
}
