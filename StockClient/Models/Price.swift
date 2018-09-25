//
//  Price.swift
//  StockClient
//
//  Created by Oleg Soloviev on 26.09.2018.
//  Copyright © 2018 varton. All rights reserved.
//

import Foundation

struct Price: Decodable {
    let currency: String
    let amount: Double
}
