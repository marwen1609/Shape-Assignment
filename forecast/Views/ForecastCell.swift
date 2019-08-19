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

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!

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
        configureHour()
        configureTemperature()
        configureWeather()
    }

    private func configureHour() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let hour = dateFormatter.string(from: forecast.dateTime)
        hourLabel.text = hour
    }

    private func configureTemperature() {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.numberStyle = .decimal
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter = numberFormatter
        let weatherTemperature = Measurement(value: forecast.main.temperature, unit: UnitTemperature.kelvin)
        let temperature = measurementFormatter.string(from: weatherTemperature)
        temperatureLabel.text = temperature
    }

    private func configureWeather() {
        let weather = forecast.weather.first?.main ?? "N/A"
        weatherLabel.text = weather
    }

}
