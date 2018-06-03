//
//  ProductViewController.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AlamofireImage

class ProductViewController: UIViewController {

    // MARK: ViewModel
    private var viewModel:ProductViewModel?

    // MARK: IBOutlets
    @IBOutlet weak var imageView_thumbnail: UIImageView!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_rating: UILabel!
    @IBOutlet weak var label_newPrice: UILabel!
    @IBOutlet weak var label_oldPrice: UILabel!
    @IBOutlet weak var textView_description: UITextView!
    @IBOutlet weak var view_images: UIView!
    @IBOutlet weak var view_specifications: UIView!
    @IBOutlet weak var view_prosCons: UIView!
    @IBOutlet weak var view_deliveredWith: UIView!
    @IBOutlet weak var view_accessories: UIView!
    @IBOutlet weak var view_reviews: UIView!

    // MARK: Private
    private var displayedProduct:Product?
    private var disposeBag = DisposeBag()

    // MARK: Overrider
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewModel()
        configureUI()
    }

    // MARK: Setter
    func setDisplayedProduct(with product:Product){
        displayedProduct = product
    }

    // MARK: Binding
    private func configureViewModel() {

        guard displayedProduct != nil else {
            return
        }
        viewModel = ProductViewModel(inputProduct: displayedProduct!,
                                     disposeBag: disposeBag)
        let outputs = viewModel?.outputs

        outputs?.title
            .bind(to: self.label_title.rx.text)
            .disposed(by: disposeBag)

        outputs?.ratingCount
            .bind(to: self.label_rating.rx.text)
            .disposed(by: disposeBag)

        outputs?.newPrice
            .bind(to: self.label_newPrice.rx.text)
            .disposed(by: disposeBag)

        outputs?.oldPrice
            .bind(to: self.label_oldPrice.rx.text)
            .disposed(by: disposeBag)

        outputs?.description
            .bind(to: self.textView_description.rx.text)
            .disposed(by: disposeBag)

        outputs?.image
            .subscribe(onNext: {  URLString in
                print(URLString)
                if let url = URL(string:URLString){
                    self.imageView_thumbnail.af_setImage(withURL: url)
                }
            })
            .disposed(by: disposeBag)
    }

    private func configureUI(){

    }
}
