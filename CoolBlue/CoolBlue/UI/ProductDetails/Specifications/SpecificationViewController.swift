//
//  SpecificationViewController.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SpecificationViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: Private
    private var disposeBag = DisposeBag()

    public func configureUI(with images:Observable<[SpecificationSum]>?){
        if let images = images{
            images
                .debug("Binding images colectionView")
                .bind(to: collectionView.rx.items(cellIdentifier: "cell")) {
                    (index, spec: SpecificationSum, cell:SpecificationCollectionViewCell) in
                    if let name = spec.name{
                        cell.label_title.text = name
                    }
                    if let desc = spec.stringValue{
                        cell.textView_desc.text = desc
                    }
                    else if let boolValue = spec.booleanValue{
                        cell.textView_desc.text = boolValue ? "Yes":"No"
                    }
                }
                .disposed(by: disposeBag)
        }
    }
}
