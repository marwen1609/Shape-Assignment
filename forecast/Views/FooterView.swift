//
//  FooterView.swift
//  forecast
//
//  Created by haifa on 20/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit
import Entities

protocol FooterViewDataSource: class {
    func forecast() -> ForecastList
}

final class FooterView: UIView {
    
    // MARK: - Properties
    
     weak var footerViewDataSource: FooterViewDataSource?
    
    // MARK: - Initilizers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(splitView)
        addSubview(humidityLabel)
        addSubview(humidityTitleLabel)
        addSubview(windLabel)
        addSubview(windTitleLabel)
        addSubview(secondSplitView)
        addSubview(rainLabel)
        addSubview(rainTitleLabel)
        addSubview(pressureLabel)
        addSubview(pressureTitleLabel)
        
        layoutSplitView()
        layoutHumidityLabel()
        layoutWindLabel()
        layoutSecondSplitView()
        layoutRainLabel()
        layoutPressureLabel()
        layoutHumidityTitleLabel()
        layoutWindTitleLabel()
        layoutRainTitleLabel()
        layoutPressureTitleLabel()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    
    lazy var splitView:UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var secondSplitView:UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var humidityLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "56 %"
        return label
    }()
    lazy var humidityTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        label.font = label.font.withSize(13)
        label.text = "HUMIDITY"
        return label
    }()
    
    lazy var windLabel: UILabel = {
        var label = UILabel()
        label.text = "E 18 mph"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    lazy var windTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "WIND"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        label.font = label.font.withSize(13)
        return label
    }()
    
    lazy var rainLabel: UILabel = {
        var label = UILabel()
        label.text = "50 in"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    lazy var rainTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "PRECIPITATION"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        label.font = label.font.withSize(13)
        return label
    }()
    
    lazy var pressureLabel: UILabel = {
        var label = UILabel()
        label.text = "50 inHg"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    lazy var pressureTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "PRESSURE"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        label.font = label.font.withSize(13)
        return label
    }()
    
    // MARK: - Constraints
    
    func layoutSplitView(){
        NSLayoutConstraint.activate([
            splitView.topAnchor.constraint(equalTo: topAnchor,constant:10),
            splitView.leadingAnchor.constraint(equalTo: leadingAnchor),
            splitView.trailingAnchor.constraint(equalTo: trailingAnchor),
            splitView.heightAnchor.constraint(equalToConstant: 1),
            ])
    }
    
    func layoutHumidityLabel(){
        NSLayoutConstraint.activate([
            humidityLabel.heightAnchor.constraint(equalToConstant: 40),
            humidityLabel.topAnchor.constraint(equalTo: humidityTitleLabel.bottomAnchor,constant: 10),
            humidityLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            humidityLabel.trailingAnchor.constraint(greaterThanOrEqualTo: windLabel.leadingAnchor,constant: -25),
            humidityLabel.bottomAnchor.constraint(equalTo: secondSplitView.topAnchor,constant: -10)
            ])
    }
    
    func layoutHumidityTitleLabel(){
        NSLayoutConstraint.activate([
            humidityTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            humidityTitleLabel.topAnchor.constraint(equalTo: splitView.bottomAnchor,constant: 10),
            humidityTitleLabel.leadingAnchor.constraint(equalTo: humidityLabel.leadingAnchor),
            humidityTitleLabel.trailingAnchor.constraint(equalTo: humidityLabel.trailingAnchor),
            ])
    }
    
    func layoutWindLabel(){
        NSLayoutConstraint.activate([
            windLabel.heightAnchor.constraint(equalToConstant: 40),
            windLabel.topAnchor.constraint(equalTo: windTitleLabel.topAnchor,constant: 10),
            windLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor,constant: -16),
            windLabel.bottomAnchor.constraint(equalTo: secondSplitView.topAnchor,constant: -10)
            ])
    }
    
    func layoutWindTitleLabel(){
        NSLayoutConstraint.activate([
            windTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            windTitleLabel.topAnchor.constraint(equalTo: splitView.bottomAnchor,constant: 10),
            windTitleLabel.leadingAnchor.constraint(equalTo: windLabel.leadingAnchor),
            windTitleLabel.trailingAnchor.constraint(equalTo: windLabel.trailingAnchor),
            ])
    }
    
    func layoutSecondSplitView(){
        NSLayoutConstraint.activate([
            secondSplitView.heightAnchor.constraint(equalToConstant: 1),
            secondSplitView.leadingAnchor.constraint(equalTo: leadingAnchor),
            secondSplitView.trailingAnchor.constraint(equalTo: trailingAnchor),

            ])
    }
    func layoutRainLabel(){
        NSLayoutConstraint.activate([
            rainLabel.heightAnchor.constraint(equalToConstant: 40),
            rainLabel.topAnchor.constraint(equalTo: rainTitleLabel.topAnchor,constant: 10),
            rainLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            rainLabel.trailingAnchor.constraint(greaterThanOrEqualTo: pressureLabel.leadingAnchor,constant: -25),
            ])
    }
    func layoutRainTitleLabel(){
        NSLayoutConstraint.activate([
            rainTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            rainTitleLabel.topAnchor.constraint(equalTo: secondSplitView.bottomAnchor,constant: 10),
            rainTitleLabel.leadingAnchor.constraint(equalTo: rainLabel.leadingAnchor),
            rainTitleLabel.trailingAnchor.constraint(equalTo: rainLabel.trailingAnchor),
            ])
    }
    func layoutPressureLabel(){
        NSLayoutConstraint.activate([
            pressureLabel.heightAnchor.constraint(equalToConstant: 40),
            pressureLabel.topAnchor.constraint(equalTo: pressureTitleLabel.topAnchor,constant: 10),
            pressureLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            pressureLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 10)

            ])
    }
    func layoutPressureTitleLabel(){
        NSLayoutConstraint.activate([
            pressureTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            pressureTitleLabel.topAnchor.constraint(equalTo: secondSplitView.bottomAnchor,constant: 10),
            pressureTitleLabel.leadingAnchor.constraint(equalTo: pressureLabel.leadingAnchor),
            pressureTitleLabel.trailingAnchor.constraint(equalTo: pressureLabel.trailingAnchor),
            ])
    }
    
    // MARK: - Members
    
    func setupLayoutWithData(){
        let forecast = footerViewDataSource?.forecast()
        humidityLabel.text = (forecast?.main.humidity.description ?? "0" ) + "%"
        rainLabel.text = (forecast?.rain?.lastThreeHours?.description ?? "0" ) + "in"
        let pressure = forecast?.main.pressure ?? 0
        pressureLabel.text = configurePressure(pressure: pressure)
        windLabel.text = (forecast?.wind.speed.description ?? "0") + "m/s"
    }
    
    fileprivate func configurePressure(pressure: Pressure) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.numberStyle = .decimal
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter = numberFormatter
        let weatherPressure = Measurement(value: pressure, unit: UnitPressure.hectopascals)
        return measurementFormatter.string(from: weatherPressure)
    }
    
}
