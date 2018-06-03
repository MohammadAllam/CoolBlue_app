//
//  ImageCollectionViewCell.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit
import AlamofireImage

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView_thumbnail: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView_thumbnail.image = Image(named: "DefaultThumbnail")
    }
}
