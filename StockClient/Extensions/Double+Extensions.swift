//
//  Double+Extensions.swift
//  StockClient
//
//  Created by Oleg Soloviev on 25.09.2018.
//  Copyright © 2018 varton. All rights reserved.
//

import Foundation

extension Double {
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        return formatter
    }()
    
    var formatted: String {
        return Double.formatter.string(for: self) ?? String(self)
    }

}
