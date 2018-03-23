//
//  CollectionViewCell.swift
//  MovieTMDB
//
//  Created by Akshay on 3/17/18.
//  Copyright © 2018 Akshay. All rights reserved.
//

import Foundation
import UIKit

class CollectionCell: UICollectionViewCell {
    
    var collimg = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(collimg)
        
        collimg.frame = CGRect(x: 0, y: 0, width: 230, height: 200)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

