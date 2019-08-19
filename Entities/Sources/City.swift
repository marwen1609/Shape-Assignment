//
//  City.swift
//  Entities
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

public class City: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case coordinate = "coord"
        case countryCode = "country"
    }
    public let name: String?
    public let coordinate: Coordinate
    public let countryCode: String?
}
