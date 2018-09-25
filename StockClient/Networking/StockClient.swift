//
//  StockClient.swift
//  StockClient
//
//  Created by Oleg Soloviev on 25.09.2018.
//  Copyright © 2018 varton. All rights reserved.
//

import Foundation

final class StockClient {
    private lazy var baseURL: URL = {
        return URL(string: "http://phisix-api3.appspot.com/stocks.json")!
    }()
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchStocks(completion: @escaping (Result<StockResponse, DataResponseError>) -> Void) {
        let urlRequest = URLRequest(url: baseURL)
        
        session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(DataResponseError.network))
                    return
            }
            guard let decodedResponse = try? JSONDecoder().decode(StockResponse.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            
            completion(Result.success(decodedResponse))
        }).resume()
    }
}
