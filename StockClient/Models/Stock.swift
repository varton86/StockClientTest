//
//  Stock.swift
//  StockClient
//
//  Created by Oleg Soloviev on 25.09.2018.
//  Copyright © 2018 varton. All rights reserved.
//

import Foundation

struct Stock: Decodable {
    let name: String
    let volume: Double
    let price: Price
}
