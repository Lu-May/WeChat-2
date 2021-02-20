//
//  TweetCell.swift
//  WeChat-2
//
//  Created by Yuehuan Lu on 2021/2/5.
//

import UIKit

class TweetCell: UITableViewCell {
  @IBOutlet weak var avatarImage: UIImageView!
  @IBOutlet weak var nickLabel: UILabel!
  @IBOutlet weak var contentLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var commentsLabel: UILabel!
  
  var tweet: Tweet?
  
  private lazy var collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 0)
  private lazy var collectionViewWidthConstraint = collectionView.widthAnchor.constraint(equalToConstant: 100)
  var myString = ""
  
  func configure(with tweet: Tweet) {
    commentsLabel.text = ""
    self.tweet = tweet
    nickLabel.text = tweet.sender?.nick ?? ""
    contentLabel.text = tweet.content ?? ""
    
    if let avatar = tweet.sender?.avatar {
      avatarImage.setImage(withURL: avatar)
    }
    myString = ""
    setCommentsLabelText(tweet)
    setCollectionViewHeightAndWidthConstraint(tweet)
    
    collectionView.reloadData()
    collectionView.layoutIfNeeded()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    avatarImage.image = nil
    
    self.collectionView.delegate =  self
    self.collectionView.dataSource =  self
    collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.collectionView.register(UINib(nibName: "TweetImageCell", bundle: nil), forCellWithReuseIdentifier: "TweetImageCell")
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionViewHeightConstraint.isActive = true
    collectionViewWidthConstraint.isActive = true
  }
  
  private func setCollectionViewHeightAndWidthConstraint(_ tweet: Tweet) {
    if tweet.images == nil || tweet.images?.count == 0 {
      collectionViewHeightConstraint.constant = 0
      collectionViewWidthConstraint.constant = 309
    } else {
      self.setUpCollectionViewWidth(count: (tweet.images?.count)!)
    }
  }
  
  func setUpCollectionViewWidth(count: Int) {
    if count == 4 {
      collectionViewWidthConstraint.constant = 200
    } else {
      collectionViewWidthConstraint.constant = 309
    }
  }
  
  func setUpCollectionViewHeight(count: Int, width: CGFloat) {
    if count <= 3 {
      collectionViewHeightConstraint.constant = width
    } else if count <= 6 {
      collectionViewHeightConstraint.constant = width * 2 + 20
    } else {
      collectionViewHeightConstraint.constant = width * 3 + 30
    }
  }
  
  private func setCommentsLabelText(_ tweet: Tweet) {
    var commentsCount = tweet.comments?.count
    let strings = NSMutableAttributedString(string: "")
    if let comments = tweet.comments {
      for comment in comments {
        commentsCount = commentsCount! - 1
        if commentsCount == 0 {
          let myString = comment.sender?.nick ?? ""
          let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor(red: 2/225, green: 29/225, blue: 140/225, alpha: 1) ]
          let myAttrString = NSMutableAttributedString(string: myString, attributes: myAttribute)
          let attrString = NSAttributedString(string: ": \(comment.content ?? "")")
          myAttrString.append(attrString)
          strings.append(myAttrString)
          commentsLabel.attributedText = strings
        } else {
          let myString = comment.sender?.nick ?? ""
          let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor(red: 2/225, green: 29/225, blue: 140/225, alpha: 1) ]
          let myAttrString = NSMutableAttributedString(string: myString, attributes: myAttribute)
          let attrString = NSAttributedString(string: ": \(comment.content ?? "")\n")
          myAttrString.append(attrString)
          strings.append(myAttrString)
          commentsLabel.attributedText = strings
        }
      }
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    avatarImage?.image = nil
  }
}

extension TweetCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let image = tweet?.images else {
      return 0
    }
    return image.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TweetImageCell", for: indexPath) as! TweetImageCell
    let data = tweet?.images![indexPath.row]
    cell.configure(with: data?.url ?? "")
    return cell
  }
}

extension TweetCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    var width = CGFloat()
    if (tweet?.images!.count)! == 1 || (tweet?.images!.count)! == 4 {
      width = ((self.collectionView?.bounds.size.width)!) / 2 - 10
    } else {
      width = ((self.collectionView?.bounds.size.width)!) / 3 - 10
    }
    self.setUpCollectionViewHeight(count: (tweet?.images!.count)!, width: width)
    return CGSize(width: width, height: width)
  }
}
