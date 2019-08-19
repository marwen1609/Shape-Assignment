//
//  ErrorView.swift
//  forecast
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit

protocol LayoutProtocol {
    func setLayout()
}

protocol ErrorViewDelegate: AnyObject {
    func didTapTryAgainButton()
}

class ErrorView: UIView {

    weak var delegate: ErrorViewDelegate?

    lazy var messageLabel: UILabel = {
        let messageLabel = UILabel(frame: .zero)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        return messageLabel
    }()
    lazy var button: UIButton = {
        let height: CGFloat = 44.0
        let button = UIButton(frame: .zero)
        button.layer.cornerRadius = height/2.0
        button.setTitle("Try again", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 255.0/255.0, green: 115.0/255.0, blue: 1.0/255.0, alpha: 1.0)
        return button
    }()

    init() {
        super.init(frame: .zero)
        addSubview(messageLabel)
        addSubview(button)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private methods

    private func layoutAllSubviews() {
        layoutMessageLabel()
        layoutButton()
    }

    private func layoutMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -89.0),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0)
            ])
    }

    private func layoutButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 21.0),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.widthAnchor.constraint(greaterThanOrEqualToConstant: 144.0),
            button.heightAnchor.constraint(equalToConstant: 44.0)
            ])
    }

    @objc
    private func didTapButton() {
        delegate?.didTapTryAgainButton()
    }

}

extension ErrorView: LayoutProtocol {
    func setLayout() {
        let superview = self.superview!
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            ])
        layoutAllSubviews()
    }
}
