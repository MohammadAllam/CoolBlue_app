//
//  ImagesViewController.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ImagesViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var collectionView_images: UICollectionView!

    // MARK: Private
    private var disposeBag = DisposeBag()

    public func configureUI(with images:Observable<[String]>?){
        if let images = images{
            images
                .debug("Binding images colectionView")
                .bind(to: collectionView_images.rx.items(cellIdentifier: "cell")) {
                    (index, imageURLString: String, cell:ImageCollectionViewCell) in
                    if let url = URL(string: imageURLString){
                        cell.imageView_thumbnail.af_setImage(withURL: url)
                    }
                }
                .disposed(by: disposeBag)
        }
    }
}
