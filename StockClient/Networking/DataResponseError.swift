//
//  DataResponseError.swift
//  StockClient
//
//  Created by Oleg Soloviev on 25.09.2018.
//  Copyright © 2018 varton. All rights reserved.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data ".localizedString
        case .decoding:
            return "An error occurred while decoding data".localizedString
        }
    }
}
