//
//  Forecast.swift
//  API
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

import Entities
import Client

extension ForecastFiveDays {
    public static func getForecast(for coordinate: Coordinate) -> Request<ForecastFiveDays, APIError> {
        let latitude = URLQueryItem(name: "lat", value: String(coordinate.latitude!))
        let longitude = URLQueryItem(name: "lon", value: String(coordinate.longitude!))
        return Request(
            url: URL(string: "forecast")!,
            method: .get,
            parameters: [QueryParameters([latitude, longitude])],
            resource: decodeResource(ForecastFiveDays.self),
            error: APIError.init,
            needsAuthorization: true
        )
    }
}

