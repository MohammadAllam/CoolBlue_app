//
//  AccessoryCollectionViewCell.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit

class AccessoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textView_text: UITextView!

    override func prepareForReuse() {
        super.prepareForReuse()

        textView_text.text = ""
    }
}
