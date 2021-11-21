//
//  StockChartExtension.swift
//  NewsApp
//
//  Created by Marinò, Marco on 18/11/21.
//

import UIKit
import Charts

class StockChartGenerator {
    
    static func initChart(chart: LineChartView, entries: [[ChartDataEntry] : (UIColor, String)]) {
         chart.chartDescription?.enabled = true
         chart.xAxis.drawGridLinesEnabled = true
         chart.xAxis.drawLabelsEnabled = true
         chart.xAxis.drawAxisLineEnabled = true
         chart.leftAxis.enabled = false
         chart.rightAxis.enabled = true
         chart.drawBordersEnabled = false
         chart.dragDecelerationEnabled = true
         chart.dragEnabled = true
         chart.highlightPerTapEnabled = true
         chart.xAxis.granularityEnabled = true
         
         chart.xAxis.labelPosition = .bottom
         chart.legend.form = .none
         chart.xAxis.valueFormatter = StockChartFormatter()
         chart.xAxis.granularity = 1
         
         chart.data = addData(entries)
    }
    
    static func addData(_ entries: [[ChartDataEntry] : (UIColor, String)]) -> LineChartData {
        return LineChartData(dataSets: generateLineDataSet(entries: entries))
    }
    
    static func generateLineDataSet(entries: [[ChartDataEntry]: (UIColor, String)]) -> [LineChartDataSet] {
        
        var finalChartDataSet = [LineChartDataSet]()
        
        for entry in entries {
            let dataSet = LineChartDataSet(entries: entry.key, label: entry.value.1)
            dataSet.colors = [entry.value.0]
            dataSet.mode = .linear
            dataSet.drawCircleHoleEnabled = false
            dataSet.drawCirclesEnabled = false
            dataSet.lineWidth = 2
            dataSet.valueTextColor = entry.value.0
            dataSet.drawValuesEnabled = false
            dataSet.fill = Fill.fillWithColor(entry.value.0)
            dataSet.drawFilledEnabled = true
            
            finalChartDataSet.append(dataSet)
            
        }
     
        return finalChartDataSet
    }
}

class StockChartFormatter: NSObject, IAxisValueFormatter {
    
    private func formatType(form: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = form
        return dateFormatter
    }
    
    private func toHour(value: Double) -> String {
        return formatType(form: "HH:mm").string(from: Date(timeIntervalSince1970: value))
    }
    
    private func toDay(value: Double) -> String {
        return formatType(form: "dd/MM").string(from: Date(timeIntervalSince1970: value))
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        return toDay(value: value)
        
    }
    
}
