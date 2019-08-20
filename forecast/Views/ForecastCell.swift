//
//  ForecastCell.swift
//  forecast
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit
import Entities

final class ForecastCell: UITableViewCell {

    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    private weak var forecast: ForecastList!
    
    override class func reuseIdentifier() -> String {
        return "ForecastCell"
    }

    class func heightForCell() -> Int {
        return 89
    }

    class func cell(tableView: UITableView, forecast: ForecastList) -> ForecastCell {
        let reuseIdentifier = self.reuseIdentifier()
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        let customCell = cell as? ForecastCell
        customCell?.forecast = forecast
        customCell?.configure()
        return customCell!
    }

    // MARK: Private methods

    private func configure() {
        configureDay()
        configureTemperature()
        configureWeather()
    }

    private func configureDay() {
        var dateFormatter: DateFormatter {
            let template = "EEEE"
            let format = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: Locale.current)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            return dateFormatter
        }
        weekDayLabel.text = dateFormatter.string(from: forecast.dateTime)
    }

    private func configureTemperature() {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.numberStyle = .decimal
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter = numberFormatter
        let maxTemperature = Measurement(value: forecast.main.maximumTemperature, unit: UnitTemperature.kelvin)
        let minTemperature = Measurement(value: forecast.main.minimumTemperature, unit: UnitTemperature.kelvin)
        let maxTemp = measurementFormatter.string(from: maxTemperature)
        let minTemp = measurementFormatter.string(from: minTemperature)
        maxTemperatureLabel.text = maxTemp
        minTemperatureLabel.text = minTemp
    }

    private func configureWeather() {
        var weather = forecast.weather.first?.icon ?? "02d"
        weather.removeLast()
        weather.append("d")
        weatherImage.image = UIImage(named: weather)
    }

}
