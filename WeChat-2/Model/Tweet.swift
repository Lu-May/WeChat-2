//
//  Tweet.swift
//  WeChat-2
//
//  Created by Yuehuan Lu on 2021/2/7.
//

import Foundation

struct Sender: Codable {
  var username: String
  var nick: String
  var avatar: String
}

struct Image: Codable {
  var url: String
}

struct Comment: Codable {
  var content: String?
  var sender: Sender?
}

struct Tweet: Codable {
  var content: String?
  var sender: Sender?
  var images: [Image]?
  var comments: [Comment]?
}
