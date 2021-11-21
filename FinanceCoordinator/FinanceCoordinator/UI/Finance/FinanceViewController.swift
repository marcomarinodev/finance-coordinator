//
//  FinanceViewController.swift
//  NewsApp
//
//  Created by Marinò, Marco on 12/11/21.
//

import UIKit
import Reusable

protocol FinanceViewControllerDelegate: AnyObject {
    func financeViewControllerDidQuery(_ financeViewController: FinanceViewController, query: String)
    func financeViewControllerDidTapDetails(_ financeViewController: FinanceViewController, stockName: String)
}

class FinanceViewController: UIViewController {

    @IBOutlet weak var stockSearchBar: UISearchBar!
    @IBOutlet weak var stocksTableView: UITableView!
    
    weak var coordinatorDelegate: FinanceViewControllerDelegate?

    var stocks: ResultQueryStocks? {
        didSet {
            guard isViewLoaded, oldValue != stocks else { return }
            stocksTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Finance"
        setup()
    }
    
    func setup() {
        setupSearchBar()
        setupTableView()
    }
    
    func setupSearchBar() { stockSearchBar.delegate = self }
    
    func setupTableView() {
        stocksTableView.separatorStyle = .none
        stocksTableView.delegate = self
        stocksTableView.dataSource = self
        stocksTableView.register(cellType: StockTableViewCell.self)
        addDoneButtonOnKeyboard()
    }
    
}

// MARK: - UISearchBarDelegate
extension FinanceViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        coordinatorDelegate?.financeViewControllerDidQuery(self, query: searchText)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FinanceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let stocks = stocks, let matches = stocks.bestMatches, matches.count > 0 else { return }
        
        coordinatorDelegate?.financeViewControllerDidTapDetails(self, stockName: matches[indexPath.row].symbol)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let stocks = stocks, let matches = stocks.bestMatches else {
            return 0
        }
        
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as StockTableViewCell
        
        if let stocks = stocks, let matches = stocks.bestMatches {
            let row = matches[indexPath.row]
            cell.configure(stockName: row.symbol, companyName: row.name)
        }
        
        return cell
        
    }
}

// MARK: - Keyboard ResignFirstResponder
extension FinanceViewController {
    private func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction) )

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        stockSearchBar.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        stockSearchBar.resignFirstResponder()
    }
}

// MARK: - StoryboardSceneBased
extension FinanceViewController: StoryboardSceneBased {
    static let sceneStoryboard: UIStoryboard = UIStoryboard(name: "Finance", bundle: nil)
}
