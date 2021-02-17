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
  private var tableHeaderView = TweetsHeader()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "朋友圈"
    
    viewModel.getTweetDatas() { [weak self] in
      self?.tableView.reloadData()
    }
    
    setUpTableViewHeader()
    
    viewModel.getProfile() { [ weak self ] in
      if let profile = self?.viewModel.profile {
        self?.tableHeaderView.configure(with: profile)
      }
      self?.tableView.reloadData()
    }
    tableView.register(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "TweetCell")
    tableView.dataSource = self
    tableView.delegate = self
    tableView.estimatedRowHeight = UITableView.automaticDimension
  }
  
  private func setUpTableViewHeader() {
    let view = UIView()
    tableHeaderView = Bundle.main.loadNibNamed("TweetsHeader", owner: nil, options: nil)?.first as! TweetsHeader
    view.addSubview(tableHeaderView)
    view.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 322)
    tableHeaderView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
      tableHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableHeaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    tableView.tableHeaderView = view
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

