//
//  AccessoriesViewController.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AccessoriesViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: Private
    private var disposeBag = DisposeBag()

    public func configureUI(with images:Observable<[String]>?){
        if let images = images{
            images
                .debug("Binding images colectionView")
                .bind(to: collectionView.rx.items(cellIdentifier: "cell")) {
                    (index, accessoryID: String, cell:AccessoryCollectionViewCell) in
                    cell.textView_text.text = accessoryID
                }
                .disposed(by: disposeBag)
        }
    }
}
