//
//  ForecastDetailPresenter.swift
//  forecast
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

protocol ForecastDetailPresenterOutput: class {
    func showList()
    func showErrorMessage(_ errorMessage: String)
    func updateTitle()
}

final class ForecastDetailPresenter {
    weak var output: ForecastDetailPresenterOutput!
}

extension ForecastDetailPresenter: ForecastDetailInteractorOutput {
    func showList() {
        output.showList()
    }
    func showError(_ error: Error) {
        let errorMessage = "I'm sorry, an error occurred.\n\n:(\n\nError detail:\n\n\(error.localizedDescription)"
        output.showErrorMessage(errorMessage)
    }
    func updateTitle() {
        output.updateTitle()
    }
}

