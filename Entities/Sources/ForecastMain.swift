//
//  ForecastMain.swift
//  Entities
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

public typealias Temperature = Double
public typealias Pressure = Double
public typealias Percent = Double

public class ForecastMain: Codable {
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case humidity
    }
    public let temperature: Temperature
    public let minimumTemperature: Temperature
    public let maximumTemperature: Temperature
    public let pressure: Pressure
    public let seaLevel: Pressure
    public let groundLevel: Pressure
    public let humidity: Percent
}
