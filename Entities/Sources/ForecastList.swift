//
//  ForecastList.swift
//  Entities
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

public class ForecastList: Codable {
    enum CodingKeys: String, CodingKey {
        case main
        case weather
        case clouds
        case wind
        case rain
        case snow
        case dateTime = "dt_txt"
    }
    public let main: ForecastMain
    public let weather: [ForecastWeather]
    public let clouds: ForecastClouds
    public let wind: ForecastWind
    public let rain: ForecastRain?
    public let snow: ForecastSnow?
    public let dateTime: Date
}
