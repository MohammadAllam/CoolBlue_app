//
//  ReviewsViewController.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ReviewsViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: Private
    private var disposeBag = DisposeBag()

    public func configureUI(with images:Observable<[Review]>?){
        if let images = images{
            images
                .debug("Binding images colectionView")
                .bind(to: collectionView.rx.items(cellIdentifier: "cell")) {
                    (index, review: Review, cell:ReviewCollectionViewCell) in
                    if let ratingAvg = review.rating{
                        cell.label_rating.text = "\(ratingAvg)"
                    }
                    if let title = review.title{
                        cell.label_title.text = title
                    }
                    if let date = review.creationDate{
                        cell.label_date.text = date
                    }
                    if let text = review.description{
                        cell.textView_text.text = text
                    }
                    var prosConsText = ""
                    if let prosList = review.pros{
                        prosConsText = "PROs : \(prosList.description))"
                    }
                    if let consList = review.cons{
                        prosConsText += "CONs : \(consList.description)"
                    }
                    cell.textView_prosCons.text = prosConsText
                }
                .disposed(by: disposeBag)
        }
    }
}
