//
//  ForecastWind.swift
//  Entities
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

public typealias MetersPerSecond = Double
public typealias Degrees = Double

public class ForecastWind: Codable {
    enum CodingKeys: String, CodingKey {
        case speed
        case direction = "deg"
    }
    public let speed: MetersPerSecond
    public let direction: Degrees
}
