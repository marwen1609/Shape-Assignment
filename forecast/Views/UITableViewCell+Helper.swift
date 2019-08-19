//
//  UITableViewCell+Helper.swift
//  forecast
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {

    @objc class func reuseIdentifier() -> String {
        return ""
    }

    class func registerForReuseIn(tableView: UITableView) {
        let reuseIdentifier = self.reuseIdentifier()
        let cellClass = self
        let bundle = Bundle(for: cellClass)
        let nib = UINib.init(nibName: reuseIdentifier, bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }

}

extension UICollectionViewCell {
    
    @objc class func reuseIdentifier() -> String {
        return ""
    }
    
    class func registerForReuseIn(collectionView: UICollectionView) {
        let reuseIdentifier = self.reuseIdentifier()
        let cellClass = self
        let bundle = Bundle(for: cellClass)
        let nib = UINib.init(nibName: reuseIdentifier, bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
}
