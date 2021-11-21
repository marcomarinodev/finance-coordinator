//
//  StockTableViewCell.swift
//  NewsApp
//
//  Created by Marinò, Marco on 16/11/21.
//

import UIKit
import Reusable

class StockTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var stockName: UILabel!
    @IBOutlet weak var companyName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // MARK: - JUST DO IT
        selectionStyle = .none
    }
    
    func configure(stockName: String?, companyName: String?) {
        if let stockName = stockName, let companyName = companyName {
            self.stockName.text = stockName
            self.companyName.text = companyName
        }
    }
    
}
