//
//  StockDetailViewController.swift
//  NewsApp
//
//  Created by Marinò, Marco on 17/11/21.
//

import UIKit
import Reusable
import Charts

protocol StockDetailViewControllerDelegate: AnyObject {
    func stockDetailViewControllerSummarize (_ stockDetailViewController: StockDetailViewController, _ highIndicators: [Float]) -> (Bool, Float)
    func stockDetailViewControllerDidChangeRange (_ stockDetailViewController: StockDetailViewController, _ indexRange: Int)
}

class StockDetailViewController: UIViewController {

    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var positivityLabel: UILabel!
    @IBOutlet weak var insightsTableView: UITableView!
    @IBOutlet weak var rangeSegmentedControl: UISegmentedControl!
    
    weak var coordinatorDelegate: StockDetailViewControllerDelegate?
    
    var isPositive: Bool = false
    
    var chartResponse: ChartResponse? {
        didSet {
            guard isViewLoaded, oldValue != chartResponse else { return }
            setupDataSource()
        }
        
    }
    
    var reports: [Report]? {
        didSet {
            guard isViewLoaded, oldValue != reports else { return }
            insightsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    private func setup() {
        setupTableView()
        setupDataSource()
    }
    
    private func setupDataSource() {
        
        /// API ensures that there'so possibility that one attribute is missing and other ones not
        /// so if an attribute is undefined, then neither other attributes are
        guard
            let response = chartResponse,
            let chartType = response.chart,
            let result = chartType.result, result.count > 0,
            let timestamp = result[0].timestamp,
            let meta = result[0].meta,
            let indicators = result[0].indicators,
            let quote = indicators.quote, quote.count > 0
        else { return }
        
        guard
            let high = quote[0].high,
            let low = quote[0].low,
            let open = quote[0].open
        else { return }
        
        setupUI(timestamp, high, low, open, meta)
        title = meta.symbol
        
    }
    
    private func setupTableView() {
        insightsTableView.register(cellType: InsightTableViewCell.self)
        insightsTableView.separatorStyle = .none
    }
    
    private func setupUI(_ timestamp: [Int], _ high: [Float], _ low: [Float], _ open: [Float], _ meta: Meta) {
        
        guard let last = high.last, let first = high.first else { return }
        
        if let coordinatorDelegate = coordinatorDelegate {
            
            var value = coordinatorDelegate.stockDetailViewControllerSummarize(self, high).1
            value = round(value * 100) / 100.0
            isPositive = coordinatorDelegate.stockDetailViewControllerSummarize(self, high).0
            positivityLabel.text = isPositive ? "+\(value) - Last:\(last)" : "\(value) - Last: \(last)"
            positivityLabel.textColor = isPositive ? .systemGreen : .systemRed
            
        }
        
        plot(timestamp: timestamp, high: high, meta: meta, chartColor: (last > first) ? .systemGreen : .systemRed)
    }
    
    @IBAction func stockSegmentedControlValueChanged(_ sender: Any) {
        coordinatorDelegate?.stockDetailViewControllerDidChangeRange(self, rangeSegmentedControl.selectedSegmentIndex)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension StockDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let reports = reports {
            print(reports.count)
            return reports.count
        } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as InsightTableViewCell
        
        if let reports = reports {
            let report = reports[indexPath.row]
            cell.config(titleText: report.title, dateText: report.publishedDate, author: report.author)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// MARK: - Plotting

extension StockDetailViewController {
    
    func plot(timestamp: [Int], high: [Float], meta: Meta, chartColor: UIColor) {
        // plot data
        
        var highLineEntry = [ChartDataEntry]()
        
        for i in 0..<high.count {
            
            let highValue = ChartDataEntry(x: Double(timestamp[i]), y: Double(high[i]))
            
            highLineEntry.append(highValue)
        }
        
        StockChartGenerator.initChart(chart: lineChartView, entries: [highLineEntry: (chartColor, "")])
        
    }
}

// MARK: - StoryboardSceneBased

extension StockDetailViewController: StoryboardSceneBased {
    static let sceneStoryboard: UIStoryboard = UIStoryboard(name: "StockDetail", bundle: nil)
}

