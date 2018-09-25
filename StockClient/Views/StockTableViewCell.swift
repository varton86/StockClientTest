//
//  StockTableViewCell.swift
//  StockClient
//
//  Created by Oleg Soloviev on 25.09.2018.
//  Copyright © 2018 varton. All rights reserved.
//

import UIKit

class StockTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        configure(with: .none)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicatorView.hidesWhenStopped = true
    }
    
    func configure(with stock: Stock?) {
        if let stock = stock {
            nameLabel?.text = stock.name
            priceLabel?.text = stock.volume.formatted
            amountLabel?.text = String(format: "%0.2f",stock.price.amount)
            nameLabel.alpha = 1
            priceLabel.alpha = 1
            amountLabel.alpha = 1
            indicatorView.stopAnimating()
        } else {
            nameLabel.alpha = 0
            priceLabel.alpha = 0
            amountLabel.alpha = 0
            indicatorView.startAnimating()
        }
    }
}
