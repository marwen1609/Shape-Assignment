//
//  ForecastRain.swift
//  Entities
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

public typealias VolumeInMilimeters = Double

public class ForecastRain: Codable {
    enum CodingKeys: String, CodingKey {
        case lastThreeHours = "3h"
    }
    public let lastThreeHours: VolumeInMilimeters?
}
