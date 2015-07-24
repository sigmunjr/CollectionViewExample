//
//  ExtendedInfoCell.swift
//  CollectionView
//
//  Created by Sigmund Rolfsjord on 23.07.15.
//  Copyright (c) 2015 Sigmund Rolfsjord. All rights reserved.
//

import Foundation
//
//  CollectionViewCell.swift
//  UICollectionView
//
//  Created by Brian Coleman on 2014-09-04.
//  Copyright (c) 2014 Brian Coleman. All rights reserved.
//

import UIKit

class ExtendedInfoCell: UICollectionViewCell {
    let textLabel: UILabel!
    let imageView: UIImageView!
    
    override init(frame: CGRect) {
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 16, width: frame.size.width, height: frame.size.height*2/3))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        let textFrame = CGRect(x: 0, y: 32, width: frame.size.width, height: frame.size.height/3)
        textLabel = UILabel(frame: textFrame)
        textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        textLabel.textAlignment = .Center
        
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.redColor()
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
