//
//  ProductViewModel.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation
import RxSwift

protocol ProductViewModelOutput {
    /// Emits product title
    var title: Observable<String>! { get }

    /// Emits product total rating caount
    var ratingCount: Observable<String>! { get }

    /// Emits product rating average
    var ratingAvg: Observable<String>! { get }

    /// Emits product new price
    var newPrice: Observable<String>! { get }

    /// Emits product old price
    var oldPrice: Observable<String>! { get }

    /// Emits product thumbnail
    var image: Observable<String>! { get }

    /// Emits an array of images for the gallery
    var images: Observable<[String]>! { get }

    /// Emits a specifications list
    var specifications: Observable<[String]>! { get }

    /// Emits a pros-cons list
    var prosCons: Observable<[String:[String]]>! { get }

    /// Emits a pros-cons list
    var deliveredWith: Observable<[String]>! { get }

    /// Emits a descritpion
    var description: Observable<String>! { get }

    /// Emits reviews list
    var reviews: Observable<[String]>! { get }

    /// Emits recommended accessories
    var accessories: Observable<[String]>! { get }
}

protocol ProductViewModelType {
    var outputs: ProductViewModelOutput { get }
}

class ProductViewModel: ProductViewModelType,
ProductViewModelOutput{

    // MARK: Outputs
    var outputs: ProductViewModelOutput { return self }

    // MARK: Output
    var title: Observable<String>!{
        return titleProperty.asObservable()
    }
    var ratingCount: Observable<String>!{
        return ratingCountProperty.asObservable()
    }
    var ratingAvg: Observable<String>!{
        return ratingAvgProperty.asObservable()
    }
    var newPrice: Observable<String>!{
        return newPriceProperty.asObservable()
    }
    var oldPrice: Observable<String>!{
        return oldPriceProperty.asObservable()
    }
    var image: Observable<String>!{
        return imageProperty.asObservable()
    }
    var images: Observable<[String]>!{
        return imagesProperty.asObservable()
    }
    var deliveredWith: Observable<[String]>!{
        return deliveredWithProperty.asObservable()
    }
    var specifications: Observable<[String]>!{
        return specificationsProperty.asObservable()
    }
    var prosCons: Observable<[String:[String]]>!{
        return prosConsProperty.asObservable()
    }
    var description: Observable<String>!{
        return descriptionProperty.asObservable()
    }
    var reviews: Observable<[String]>!{
        return reviewsProperty.asObservable()
    }
    var accessories: Observable<[String]>!{
        return accessoriesProperty.asObservable()
    }

    // MARK: Private
    private var productService:ProductServiceType
    private var currentProduct:Observable<Product>
    private let titleProperty = Variable<String>("")
    private let ratingCountProperty = Variable<String>("")
    private let ratingAvgProperty = Variable<String>("")
    private let oldPriceProperty = Variable<String>("")
    private let newPriceProperty = Variable<String>("")
    private let imageProperty = Variable<String>("")
    private let imagesProperty = Variable<[String]>([])
    private let deliveredWithProperty = Variable<[String]>([])
    private let specificationsProperty = Variable<[String]>([])
    private let prosConsProperty = Variable<[String:[String]]>([:])
    private let descriptionProperty = Variable<String>("")
    private let reviewsProperty = Variable<[String]>([])
    private let accessoriesProperty = Variable<[String]>([])

    // MARK: Init
    init(inputService:ProductServiceType = ProductService(),
         inputProduct:Product,
         disposeBag:DisposeBag) {
        self.productService = inputService
        currentProduct = .just(inputProduct)

        if let name = inputProduct.productName{
            titleProperty.value = name
        }
        if let count = inputProduct.reviewInformation?.reviewSummary?.reviewCount{
            ratingCountProperty.value = "\(count)"
        }
        if let avg = inputProduct.reviewInformation?.reviewSummary?.reviewAverage{
            ratingAvgProperty.value = "\(avg)"
        }
        if let oldPrice = inputProduct.listPriceIncVat{
            oldPriceProperty.value = "\(oldPrice)"
        }
        if let newPrice = inputProduct.salesPriceIncVat{
            newPriceProperty.value = "\(newPrice)"
        }
        if let imageURLString = inputProduct.productImage{
            imageProperty.value = imageURLString
        }
    }
}

