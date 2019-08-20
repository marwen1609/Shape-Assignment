//
//  ForecastTableView.swift
//  forecast
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit
import Entities

protocol ForecastTableViewDataSource: AnyObject {
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func forecast(at index: Int, in section: Int) -> ForecastList
    func dateToShow(in section: Int) -> String
}

final class ForecastTableView: UITableView {
    
     // MARK: - Properties
    
    weak var forecastDataSource: ForecastTableViewDataSource?
    var footerForecastData: ForecastList!
     // MARK: - Initilizers
    
    init() {
        super.init(frame: .zero, style: .plain)
        dataSource = self
        delegate = self
        allowsSelection = false
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = CGFloat(ForecastCell.heightForCell())
        tableFooterView = UIView(frame: .zero)
        ForecastCell.registerForReuseIn(tableView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ForecastTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1//forecastDataSource?.numberOfSections() ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastDataSource?.numberOfSections() ?? 1 - 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let forecast = forecastDataSource!.forecast(at: indexPath.section, in: indexPath.row)
            return ForecastCell.cell(tableView: tableView, forecast: forecast)
        }
}

extension ForecastTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 185.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 180.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return  createHeaderViews(tableView: tableView, section: section)
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        footerForecastData = forecastDataSource!.forecast(at: 0, in: section)
        let height = tableView.sectionFooterHeight
        let tableViewWidth = tableView.frame.size.width
        let frame = CGRect(x: 0, y: 0, width: tableViewWidth, height: height)
        let containerView = FooterView(frame: frame)
        containerView.backgroundColor = .white
        containerView.footerViewDataSource = self
        containerView.setupLayoutWithData()
        
        return containerView
    }
    
     // MARK: - Members
    
    private func createHeaderViews(tableView: UITableView, section: Int) -> UIView{
        
        let height = tableView.sectionHeaderHeight
        let tableViewWidth = tableView.frame.size.width
        let frame = CGRect(x: 0, y: 0, width: tableViewWidth, height: height)
        let width = tableViewWidth - (2*16)
        
        let view = UIView(frame: frame)
        
        let horizontalList = ForcastCollectionView()
        horizontalList.forecastDataSource = forecastDataSource
        let dateToShow = forecastDataSource!.dateToShow(in: section)
       
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 40))
        let maxTempratureLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 40))
        let minTempratureLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 40))
        view.backgroundColor = .white
        horizontalList.backgroundColor = .white
        
        label.text = dateToShow
        minTempratureLabel.text = configureTemperature(temperature: (forecastDataSource?.forecast(at: 0, in: section).main.minimumTemperature)!)
        maxTempratureLabel.text = configureTemperature(temperature: (forecastDataSource?.forecast(at: 0, in: section).main.maximumTemperature)!)
        
        minTempratureLabel.textColor = .black
        maxTempratureLabel.textColor = .black
        label.textColor = .black
        
        minTempratureLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempratureLabel.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        horizontalList.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        view.addSubview(horizontalList)
        view.addSubview(minTempratureLabel)
        view.addSubview(maxTempratureLabel)
        
        dateLabelConstraints(label: label, view: view)
        tempratureLabelsConstraints(maxTempratureLabel: maxTempratureLabel, minTempratureLabel: minTempratureLabel, view: view)
        horizontalListConsraints(horizontalList: horizontalList, label: label, view: view)
        
        return view
    }
   
    private func configureTemperature(temperature: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.numberStyle = .decimal
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter = numberFormatter
        let weatherTemperature = Measurement(value: temperature, unit: UnitTemperature.kelvin)
        return measurementFormatter.string(from: weatherTemperature)
        
    }
    // MARK: - Layout constraints
    
    fileprivate func dateLabelConstraints(label: UILabel,view: UIView) {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view
                .topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    fileprivate func tempratureLabelsConstraints(maxTempratureLabel: UILabel,minTempratureLabel: UILabel,view: UIView) {
        NSLayoutConstraint.activate([
            maxTempratureLabel.topAnchor.constraint(equalTo: view
                .topAnchor),
            maxTempratureLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            maxTempratureLabel.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        NSLayoutConstraint.activate([
            minTempratureLabel.topAnchor.constraint(equalTo: view
                .topAnchor),
            minTempratureLabel.leadingAnchor.constraint(equalTo: maxTempratureLabel.leadingAnchor, constant: 50),
            minTempratureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            minTempratureLabel.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    fileprivate func horizontalListConsraints(horizontalList: ForcastCollectionView,label: UILabel,view: UIView) {
        NSLayoutConstraint.activate([
            horizontalList.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 10),
            horizontalList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalList.heightAnchor.constraint(equalToConstant: 135),
            horizontalList.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

extension ForecastTableView: FooterViewDataSource{
    func forecast() -> ForecastList {
        return footerForecastData
    }
    
    
}
