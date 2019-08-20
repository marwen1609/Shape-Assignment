//
//  ForecastWeather.swift
//  Entities
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//
import Foundation

public class ForecastWeather: Codable {
    public let id: Int
    public let main: String
    public let description: String
    public let icon: String
}
