
//
//  FindLocationRouter.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import MapKit
import API

final class FindLocationRouter {
    let api: ForecastClient
    let viewController: UIViewController
    init(api apiClient: ForecastClient, viewController: UIViewController) {
        self.api = apiClient
        self.viewController = viewController
    }
}

extension FindLocationRouter: FindLocationInteractorAction {
    func locationSelected(at coordinate: CLLocationCoordinate2D) {
        let viewController = ForecastDetailConfig.setup(api: api, coordinate: coordinate)
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
