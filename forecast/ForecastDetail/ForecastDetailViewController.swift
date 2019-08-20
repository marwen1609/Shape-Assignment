//
//  ForecastDetailViewController.swift
//  forecast
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit
import Entities

protocol ForecastDetailViewControllerOutput: ForecastTableViewDataSource {
    func viewIsReady()
    func tryToLoadAgain()
    func title() -> String
}

final class ForecastDetailViewController: UIViewController {

    var output: ForecastDetailViewControllerOutput!
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        return indicator
    }()
    lazy var errorView: ErrorView = {
        let errorView = ErrorView()
        errorView.delegate = self
        return errorView
    }()
    lazy var tableView: ForecastTableView = {
        let tableView = ForecastTableView()
        tableView.forecastDataSource = self
        return tableView
    }()

    // MARK: ViewController lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        navigationItem.title = output.title()
        activityIndicator.startAnimating()
        output.viewIsReady()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: Private methods

    private func startLoading() {
        view.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }

    private func stopLoading() {
        activityIndicator.stopAnimating()
    }

    private func showErrorView() {
        view.addSubview(errorView)
        errorView.setLayout()
    }

    private func hideErrorView() {
        errorView.removeFromSuperview()
    }

    private func showTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }

    private func hideTableView() {
        tableView.removeFromSuperview()
    }

}

extension ForecastDetailViewController: ForecastDetailPresenterOutput {
    func showList() {
        stopLoading()
        hideErrorView()
        showTableView()
    }
    func showErrorMessage(_ errorMessage: String) {
        stopLoading()
        hideTableView()
        showErrorView()
        errorView.messageLabel.text = errorMessage
    }
    func updateTitle() {
        navigationItem.title = output.title()
    }
}

extension ForecastDetailViewController: ErrorViewDelegate {
    func didTapTryAgainButton() {
        hideErrorView()
        hideTableView()
        startLoading()
        output.tryToLoadAgain()
    }
}

extension ForecastDetailViewController: ForecastTableViewDataSource {
    
    func numberOfSections() -> Int {
        return output.numberOfSections()
    }
    func numberOfRows(in section: Int) -> Int {
        return output.numberOfRows(in: section)
    }
    func forecast(at index: Int, in section: Int) -> ForecastList {
        return output.forecast(at: index, in: section)
    }
    func dateToShow(in section: Int) -> String {
        return output.dateToShow(in: section)
    }
}
