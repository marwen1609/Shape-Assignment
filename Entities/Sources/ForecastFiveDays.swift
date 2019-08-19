//
//  ForecastFiveDays.swift
//  Entities
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

public class ForecastFiveDays: Codable {
    public let list: [ForecastList]
    public let city: City
}
