//
//  ViewController.swift
//  WeChat-2
//
//  Created by Yuehuan Lu on 2021/2/5.
//

import UIKit

class TweetsViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  let viewModel = TweetsViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "朋友圈"
    viewModel.getTweetDatas() { [weak self] in
      self?.tableView.reloadData()
    }
    tableView.register(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "TweetCell")
    tableView.dataSource = self
    tableView.delegate = self
    tableView.estimatedRowHeight = UITableView.automaticDimension
  }
}

extension TweetsViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.tweetDatas.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as? TweetCell else {
      return UITableViewCell()
    }
    cell.configure(with: viewModel.tweetDatas[indexPath.row])
    return cell
  }
}

