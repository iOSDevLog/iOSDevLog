//
//  Search.swift
//  StoreSearch
//
//  Created by iosdevlog on 16/3/2.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import Foundation

class Search {
    var searchResults = [SearchResult]()
    var hasSearched = false
    var isLoading = false
    
    private var dataTask: NSURLSessionDataTask? = nil
    
    func performSearchForText(text: String, category: Int) {
        print("Searching...")
    }
}