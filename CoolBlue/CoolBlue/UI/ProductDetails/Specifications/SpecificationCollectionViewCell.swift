//
//  SpecificationCollectionViewCell.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit

class SpecificationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var textView_desc: UITextView!

    override func prepareForReuse() {
        super.prepareForReuse()

        label_title.text = ""
        textView_desc.text = ""
    }
}
