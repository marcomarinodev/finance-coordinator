//
//  StockDetailCoordinator.swift
//  NewsApp
//
//  Created by Marinò, Marco on 17/11/21.
//

import Foundation

final class StockDetailCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    var financeViewController: FinanceViewController?
    var stockDetailViewController: StockDetailViewController?
    var symbol: String?
    
    func start(from viewController: FinanceViewController, with symbol: String) {
        
        self.financeViewController = viewController
        self.symbol = symbol
        
        let stockDetailViewController = StockDetailViewController.instantiate()
        stockDetailViewController.coordinatorDelegate = self
        
        StockClient.getChart(symbol: symbol, range: .year) { response in
            switch response {
            case .success(let chart):
                stockDetailViewController.chartResponse = chart
                stockDetailViewController.rangeSegmentedControl.selectedSegmentIndex = ChartRange.getIndex(.year)
            case .failure(let error):
                print(error)
                break
            }
        }
        
        StockClient.getInsights(symbol: symbol) { response in
            switch response {
            case .success(let insightResponse):
                stockDetailViewController.reports = insightResponse.finance.result.reports
            case .failure(let error):
                print(error)
                break
            }
        }
        
        self.stockDetailViewController = stockDetailViewController
        
        viewController.show(stockDetailViewController, sender: nil)
        
    }
    
}

extension StockDetailCoordinator: StockDetailViewControllerDelegate {
    
    func stockDetailViewControllerSummarize(_ stockDetailViewController: StockDetailViewController, _ highIndicators: [Float]) -> (Bool, Float) {
        
        if let first = highIndicators.first, let last = highIndicators.last {
            return (last - first > 0, last - first)
        } else { return (false, 0) }
        
    }
    
    func stockDetailViewControllerDidChangeRange(_ stockDetailViewController: StockDetailViewController, _ indexRange: Int) {
    
        guard let symbol = self.symbol else { return }
        
        StockClient.getChart(symbol: symbol, range: .getRange(indexRange)) { response in
            switch response {
            case .success(let chart):
                stockDetailViewController.chartResponse = chart
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}
