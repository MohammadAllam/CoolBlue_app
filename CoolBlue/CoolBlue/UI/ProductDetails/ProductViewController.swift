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
    @IBOutlet weak var label_ratingAvg: UILabel!
    @IBOutlet weak var label_newPrice: UILabel!
    @IBOutlet weak var label_oldPrice: UILabel!
    @IBOutlet weak var label_nextDayDelivery: UILabel!
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
    private weak var imagesVC: ImagesViewController?
    private weak var specVC: SpecificationViewController?
    private weak var accessVC: AccessoriesViewController?
    private weak var reviewsVC: ReviewsViewController?

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

        outputs?.nextDayDelivery
            .bind(to: self.label_nextDayDelivery.rx.isHidden)
            .disposed(by: disposeBag)

        outputs?.ratingCount
            .bind(to: self.label_rating.rx.text)
            .disposed(by: disposeBag)

        outputs?.ratingAvg
            .bind(to: self.label_ratingAvg.rx.text)
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

        outputs?.images
            .subscribe(onNext: { imagesList in

                //                imagesVC
            })
            .disposed(by: disposeBag)
    }

    private func configureUI(){

        let outputs = viewModel?.outputs
        // Init the images view contorller
        imagesVC?.configureUI(with: outputs?.images)
        specVC?.configureUI(with: outputs?.specifications)
        accessVC?.configureUI(with: outputs?.accessories)
        reviewsVC?.configureUI(with: outputs?.reviews)
    }

    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "images"{
            imagesVC = (segue.destination as! ImagesViewController)
        }
        else if segue.identifier == "specifications"{
            specVC = (segue.destination as! SpecificationViewController)
        }
        else if segue.identifier == "prosCons"{
            
        }
        else if segue.identifier == "deliveredWith"{

        }
        else if segue.identifier == "accessories"{
            accessVC = (segue.destination as! AccessoriesViewController)
        }
        else if segue.identifier == "reviews"{
            reviewsVC = (segue.destination as! ReviewsViewController)
        }
    }
}
