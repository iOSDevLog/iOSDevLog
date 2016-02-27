//
//  SearchResultCell.swift
//  StoreSearch
//
//  Created by iosdevlog on 16/2/23.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
    // MARK: - outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    
    // MARK: - lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 0.5)
        selectedBackgroundView = selectedView
    }
    
    // MARK: - helper
    func cofnigureForSearchResult(searchResult: SearchResult) {
        nameLabel.text = searchResult.name
        
        if searchResult.artistName.isEmpty {
            artistNameLabel.text = "Unknown"
        } else {
            artistNameLabel.text = String(format: "%@ (%@)", searchResult.artistName, kindForDisplay(searchResult.kind))
        }
    }
    
    func kindForDisplay(kind: String) -> String {
        switch kind {
        case "album": return "Album"
        case "audiobook": return "Audio Book"
        case "book": return "Book"
        case "ebook": return "E-Book"
        case "feature-movie": return "Movie"
        case "music-video": return "Music Video"
        case "podcast": return "Podcast"
        case "software": return "App"
        case "song": return "Song"
        case "tv-episode": return "TV Episode"
        default: return kind
        }
    }
}
