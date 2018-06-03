//
//  ReviewCollectionViewCell.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label_rating: UILabel!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_date: UILabel!
    @IBOutlet weak var textView_prosCons: UITextView!
    @IBOutlet weak var textView_text: UITextView!

    override func prepareForReuse() {
        super.prepareForReuse()

        label_rating.text = ""
        label_title.text = ""
        label_date.text = ""
        textView_prosCons.text = ""
        textView_text.text = ""
    }
}
