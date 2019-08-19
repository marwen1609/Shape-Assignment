//
//  Coordinate.swift
//  Entities
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

public typealias CoordinateDegrees = Double

public class Coordinate: Codable {
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
    public init(latitude: CoordinateDegrees, longitude: CoordinateDegrees) {
        self.latitude = latitude
        self.longitude = longitude
    }
    public let latitude: CoordinateDegrees?
    public let longitude: CoordinateDegrees?
}
