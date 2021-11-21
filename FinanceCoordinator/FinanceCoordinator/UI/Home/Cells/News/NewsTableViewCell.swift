//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Marinò, Marco on 14/11/21.
//

import UIKit
import Reusable

class NewsTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsImageView: DownloadedImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
    }
    
    func configure(category: String, title: String, date: String, media: Multimedia?) {
        
        categoryLabel.text = category
        newsTitle.text = title
        dateLabel.text = date
        
        if let media = media {
            if let url = URL(string: media.imageURL) {
                newsImageView.loadImage(with: url)
            }
        }
        
    }
    
}
