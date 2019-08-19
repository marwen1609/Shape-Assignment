//
//  ForecastDetailConfig.swift
//  forecast
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit
import API
import MapKit
import Entities

struct ForecastDetailConfig {
    static func setup(api apiClient: ForecastClient, coordinate: CLLocationCoordinate2D) -> UIViewController {
        let viewController = ForecastDetailViewController()
        let interactor = ForecastDetailInteractor(api: apiClient)
        let presenter = ForecastDetailPresenter()

        viewController.output = interactor
        interactor.output = presenter
        interactor.coordinate = Coordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)
        presenter.output = viewController

        return viewController
    }
}
