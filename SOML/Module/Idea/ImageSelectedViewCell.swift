//
//  ImageSelectedViewCell.swift
//  SOML
//
//  Created by Maple Yin on 2019/1/29.
//  Copyright © 2019 Maple.im. All rights reserved.
//

import UIKit

class ImageSelectedViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI() {
        self.contentView.addSubview(self.imageView)
        
        self.imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }
    
    
    func setupImage() {
        
    }
}
