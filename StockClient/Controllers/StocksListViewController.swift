//
//  ViewController.swift
//  StockClient
//
//  Created by Oleg Soloviev on 25.09.2018.
//  Copyright © 2018 varton. All rights reserved.
//

import UIKit

class StocksListViewController: UIViewController, AlertDisplayer {
    private enum CellIdentifiers {
        static let cell = "Cell"
    }
    private var timer: Timer?

    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBAction func pressRefreshButton(_ sender: UIBarButtonItem) {
        refreshData()
    }
    
    private var viewModel: StocksViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorView.startAnimating()
        
        tableView.isHidden = true
        tableView.dataSource = self
        
        viewModel = StocksViewModel(delegate: self)
        viewModel.fetchStocks()
        timer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
    }
    
    @objc private func refreshData() {
        indicatorView.startAnimating()
        viewModel.fetchStocks()
    }
}

extension StocksListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.cell, for: indexPath) as! StockTableViewCell
        cell.configure(with: viewModel.stock(at: indexPath.row))
        return cell
    }
}

extension StocksListViewController: StocksViewModelDelegate {
    func onFetchCompleted() {
        indicatorView.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func onFetchFailed(with reason: String) {
        indicatorView.stopAnimating()
        
        let title = "Warning".localizedString
        let action = UIAlertAction(title: "OK".localizedString, style: .default)
        displayAlert(with: title , message: reason, actions: [action])
    }
}

