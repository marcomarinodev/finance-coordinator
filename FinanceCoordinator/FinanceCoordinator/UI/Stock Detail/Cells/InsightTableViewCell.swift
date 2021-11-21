//
//  InsightTableViewCell.swift
//  NewsApp
//
//  Created by Marinò, Marco on 19/11/21.
//

import UIKit
import Reusable

class InsightTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.textColor = .black
        dateLabel.textColor = .black
        authorLabel.textColor = .black
    }

    func config(titleText: String, dateText: String, author: String) {
        titleLabel.text = titleText
    }
    
}
