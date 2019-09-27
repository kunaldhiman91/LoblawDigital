//
//  ViewController.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-28.
//  Copyright © 2019 Kunal Kumar. All rights reserved.
//

import UIKit

/// ViewController handling displaing of Swift News Feed.
class ViewController: UIViewController {
    
    let viewModel = LDHomeViewModel()
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(LDNewsFeedCell.nib,
                                    forCellReuseIdentifier: LDNewsFeedCell.identifier)
            self.tableView.estimatedRowHeight = 600
            self.tableView.rowHeight = UITableView.automaticDimension
        }
        
    }
    
    // MARK: Properties
    private var newsArray: [LDDataViewModel]?
    
    // MARK: ViewController Life Cycles.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchSwiftNews()
        self.title = "Swift News"
    }
    
    // MARK: Private Methods.
    private func fetchSwiftNews() {
        self.viewModel.fetchNewsDetails {
            self.newsArray = self.viewModel.data
            performOnMain {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: UITableViewDelegate Methods.
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let newsArray = self.newsArray {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "LDDetailViewController") as? LDDetailViewController {
                vc.dataModel = newsArray[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

// MARK: UITableViewDataSource Methods.
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _newsArray = newsArray else {
            return 0
        }
        return _newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LDNewsFeedCell.identifier, for: indexPath) as? LDNewsFeedCell else {
            let cell = LDNewsFeedCell()
            if let newsArray = self.newsArray {
                cell.setupTableViewCell(viewModel: newsArray[indexPath.row])
            }
            return cell
        }
        if let newsArray = self.newsArray {
            
            if indexPath.row == newsArray.count - 1 {
                self.fetchSwiftNews()
            }
            cell.setupTableViewCell(viewModel: newsArray[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
    }
}
