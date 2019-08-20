//
//  ForcastCollectionViewCell.swift
//  forecast
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit
import Entities

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var forcastTimeLabel: UILabel!
    @IBOutlet weak var forcastIcon: UIImageView!
    @IBOutlet weak var forcastTempratureLabel: UILabel!
    
    private weak var forecast: ForecastList!
    
    override class func reuseIdentifier() -> String {
        return "ForecastCollectionViewCell"
    }
    
    class func cell(collectionView: UICollectionView,indexpath: IndexPath, forecast: ForecastList) -> ForecastCollectionViewCell {
        let reuseIdentifier = self.reuseIdentifier()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexpath)
        let customCell = cell as? ForecastCollectionViewCell
        customCell?.forecast = forecast
        customCell?.configure()
        return customCell!
    }
    
    // MARK: Private methods
    
    private func configure() {
        configureHour()
        configureTemperature()
        configureIcon()
    }
    
    private func configureHour() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let hour = dateFormatter.string(from: forecast.dateTime)
        forcastTimeLabel.text = hour
    }
    
    private func configureTemperature() {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.numberStyle = .decimal
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter = numberFormatter
        let weatherTemperature = Measurement(value: forecast.main.temperature, unit: UnitTemperature.kelvin)
        let temperature = measurementFormatter.string(from: weatherTemperature)
        forcastTempratureLabel.text = temperature
    }
    
    private func configureIcon(){
        let weatherIconStringName = forecast.weather.first?.icon
        forcastIcon.image = UIImage(named: weatherIconStringName ?? "02d")
    }
    
}
