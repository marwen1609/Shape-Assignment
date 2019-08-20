//
//  ForcastCollectionView.swift
//  forecast
//
//  Created by Marwen Jamel on 19/08/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit
import Entities


final class ForcastCollectionView: UICollectionView {
    
    weak var forecastDataSource: ForecastTableViewDataSource?
    
    init() {
        let flowlayout = UICollectionViewFlowLayout()
        super.init(frame: CGRect(x: 0, y: 0, width: 375, height: 135), collectionViewLayout: flowlayout)
        flowlayout.scrollDirection = .horizontal
        flowlayout.minimumLineSpacing = 0
        flowlayout.minimumLineSpacing = 0
        dataSource = self
        delegate = self
        ForecastCollectionViewCell.registerForReuseIn(collectionView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ForcastCollectionView : UICollectionViewDataSource,UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastDataSource?.numberOfRows(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let forecast = forecastDataSource!.forecast(at: indexPath.row, in: indexPath.section)
        return ForecastCollectionViewCell.cell(collectionView: collectionView, indexpath: indexPath, forecast: forecast)
    }
}

extension ForcastCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 108, height: 165)
    }
    
}
