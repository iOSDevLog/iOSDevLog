//
//  ViewController.swift
//  StoreSearch
//
//  Created by iosdevlog on 16/2/22.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: - property
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - outlet
    var searchResults = [String]()
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - extension
// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchResults = [String]()
        for i in 0...2 {
            searchResults.append(String(format: "Fake Result %d for '%@'", i, searchBar.text!))
        }
        tableView.reloadData()
    }
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
}

// MARK: - SearchViewController
extension SearchViewController: UITableViewDataSource {
    func tableView(tableView: UITableView,
            numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        searchBar.resignFirstResponder()
    
        let cellIdentifier = "SearchResultCell"
    
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
    
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        }
        cell.textLabel!.text = searchResults[indexPath.row]
    
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
}