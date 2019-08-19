//
//  ForecastDetailInteractor.swift
//  forecast
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation
import API
import Entities

protocol ForecastDetailInteractorOutput: class {
    func showList()
    func showError(_ error: Error)
    func updateTitle()
}

final private class ForecastTableViewElement {
    let dateToShow: String
    var list: [ForecastList] = []
    init(dateToShow: String) {
        self.dateToShow = dateToShow
    }
}

final class ForecastDetailInteractor {

    var output: ForecastDetailInteractorOutput!
    var coordinate: Coordinate!

    let api: ForecastClient

    private var forecastFiveDays: ForecastFiveDays?

    private var dateFormatter: DateFormatter {
        let template = "EEEEdMMM"
        let format = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: Locale.current)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter
    }

    private var listForTableView: [ForecastTableViewElement] = []

    init(api apiClient: ForecastClient) {
        self.api = apiClient
    }

    private func getForecast() {
        api.perform(ForecastFiveDays.getForecast(for: coordinate)) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case let .success(forecastFiveDays):
                    self?.forecastFiveDays = forecastFiveDays
                    self?.formatListToTableView()
                    self?.output.showList()
                    self?.output.updateTitle()
                case let .failure(error):
                    self?.output.showError(error)
                }
            }
        }
    }

    private func formatListToTableView() {
        let dateFormatter = self.dateFormatter
        listForTableView = []
        for forecast in forecastFiveDays!.list {
            var itWasAdded = false
            for element in listForTableView {
                let currentForecastDate = dateFormatter.string(from: forecast.dateTime)
                if currentForecastDate == element.dateToShow {
                    element.list.append(forecast)
                    itWasAdded = true
                    break
                }
            }
            if !itWasAdded {
                let dateToShow = dateFormatter.string(from: forecast.dateTime)
                let newElement = ForecastTableViewElement(dateToShow: dateToShow)
                newElement.list.append(forecast)
                listForTableView.append(newElement)
            }
        }
    }

    private func cityName() -> String {
        return forecastFiveDays?.city.name ?? ""
    }

    private func countryCode() -> String {
        return forecastFiveDays?.city.countryCode ?? ""
    }

}

extension ForecastDetailInteractor: ForecastDetailViewControllerOutput {
    func viewIsReady() {
        getForecast()
    }
    func tryToLoadAgain() {
        getForecast()
    }
    func title() -> String {
        let cityName = self.cityName()
        if cityName.isEmpty {
            return "Forecast"
        }
        let countryCode = self.countryCode()
        if countryCode.isEmpty {
            return "Forecast - \(cityName)"
        }
        return "Forecast - \(cityName), \(countryCode)"
    }
    func numberOfSections() -> Int {
        return listForTableView.count
    }
    func numberOfRows(in section: Int) -> Int {
        return listForTableView[section].list.count
    }
    func forecast(at index: Int, in section: Int) -> ForecastList {
        return listForTableView[section].list[index]
    }
    func dateToShow(in section: Int) -> String {
        return listForTableView[section].dateToShow
    }
}
