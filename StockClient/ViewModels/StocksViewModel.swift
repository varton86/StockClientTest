//
//  StocksViewModel.swift
//  StockClient
//
//  Created by Oleg Soloviev on 25.09.2018.
//  Copyright © 2018 varton. All rights reserved.
//

import Foundation

protocol StocksViewModelDelegate: class {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}

final class StocksViewModel {
    private weak var delegate: StocksViewModelDelegate?
    
    private var stocks: [Stock] = []
    private var isFetchInProgress = false
    
    let client = StockClient()
    
    init(delegate: StocksViewModelDelegate) {
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return stocks.count
    }
    
    func stock(at index: Int) -> Stock {
        return stocks[index]
    }
    
    func fetchStocks() {
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        
        client.fetchStocks() { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: error.reason)
                }
            case .success(let response):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.stocks = [Stock]()
                    self.stocks.append(contentsOf: response.stock)
                    self.delegate?.onFetchCompleted()
                }
            }
        }
    }
}
