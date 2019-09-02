//
//  ViewController.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-28.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(LDNewsFeedCell.nib,
                                    forCellReuseIdentifier: LDNewsFeedCell.identifier)
            self.tableView.estimatedRowHeight = 100
            self.tableView.rowHeight = UITableView.automaticDimension
        }
        
    }
    
    private var newsArray: [LDDataViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testNetworkCall()
        self.title = "Swift News"
        // Do any additional setup after loading the view.
    }
    
    
    func testNetworkCall() {
        
        let vm = LDHomeViewModel()
        vm.fetchNewsDetails {
            self.newsArray = vm.data
            
            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
        }
        
    }
}

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
                cell.viewModel = newsArray[indexPath.row]
                cell.setupTableViewCell()
            }
            return cell
        }
        
        if let newsArray = self.newsArray {
            cell.viewModel = newsArray[indexPath.row]
            cell.setupTableViewCell()
        }
        
        return cell
        
    }
    
    
    
}
