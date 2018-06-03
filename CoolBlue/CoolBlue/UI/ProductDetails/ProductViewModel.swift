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

    /// Emits product next day delivery flag
    var nextDayDelivery: Observable<Bool>! { get }

    /// Emits product new price
    var newPrice: Observable<String>! { get }

    /// Emits product old price
    var oldPrice: Observable<String>! { get }

    /// Emits product thumbnail
    var image: Observable<String>! { get }

    /// Emits an array of images for the gallery
    var images: Observable<[String]>! { get }

    /// Emits a specifications list
    var specifications: Observable<[SpecificationSum]>! { get }

    /// Emits a pros-cons list
    var prosCons: Observable<[String:[String]]>! { get }

    /// Emits a pros-cons list
    var deliveredWith: Observable<[String]>! { get }

    /// Emits a descritpion
    var description: Observable<String>! { get }

    /// Emits reviews list
    var reviews: Observable<[Review]>! { get }

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
    var nextDayDelivery: Observable<Bool>! {
        return nextDayDeliveryProperty.asObservable()
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
    var specifications: Observable<[SpecificationSum]>!{
        return specificationsProperty.asObservable()
    }
    var prosCons: Observable<[String:[String]]>!{
        return prosConsProperty.asObservable()
    }
    var description: Observable<String>!{
        return descriptionProperty.asObservable()
    }
    var reviews: Observable<[Review]>!{
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
    private let nextDayDeliveryProperty = Variable<Bool>(false)
    private let oldPriceProperty = Variable<String>("")
    private let newPriceProperty = Variable<String>("")
    private let imageProperty = Variable<String>("")
    private let imagesProperty = Variable<[String]>([])
    private let deliveredWithProperty = Variable<[String]>([])
    private let specificationsProperty = Variable<[SpecificationSum]>([])
    private let prosConsProperty = Variable<[String:[String]]>([:])
    private let descriptionProperty = Variable<String>("")
    private let reviewsProperty = Variable<[Review]>([])
    private let accessoriesProperty = Variable<[String]>([])

    // MARK: Init
    init(inputService:ProductServiceType = ProductService(),
         inputProduct:Product,
         disposeBag:DisposeBag) {
        self.productService = inputService
        currentProduct = .just(inputProduct)

        // Setting data that already exists
        if let name = inputProduct.productName{
            titleProperty.value = name
        }
        if let count = inputProduct.reviewInformation?.reviewSummary?.reviewCount{
            ratingCountProperty.value = "Review count :\(count)"
        }
        if let avg = inputProduct.reviewInformation?.reviewSummary?.reviewAverage{
            ratingAvgProperty.value = "Review avg :\(avg)"
        }
        if let nextDay = inputProduct.nextDayDelivery{
            nextDayDeliveryProperty.value = nextDay
        }
        if let oldPrice = inputProduct.listPriceIncVat{
            oldPriceProperty.value = "List price :\(oldPrice)"
        }
        if let newPrice = inputProduct.salesPriceIncVat{
            newPriceProperty.value = "Sales price :\(newPrice)"
        }
        if let imageURLString = inputProduct.productImage{
            imageProperty.value = imageURLString
        }

        // Fetching detailed item to fill the rest of the data
        currentProduct = productService.productDetails(with: inputProduct.productId!).asObservable()
        currentProduct.subscribe(onNext: { [unowned self] productItem in

            if let desc = productItem.productText{
                self.descriptionProperty.value = desc
            }
            if let list = productItem.productImages{
                self.imagesProperty.value = list
            }
            if let list = productItem.specificationSummary{
                self.specificationsProperty.value = list
            }
            if let list = productItem.deliveredWith{
                self.deliveredWithProperty.value = list
            }
            var prosConsDic:[String:[String]] = [:]
            if let pros = productItem.pros{
                prosConsDic["pros"] = pros
            }
            if let cons = productItem.cons{
                prosConsDic["pros"] = cons
            }
            self.prosConsProperty.value = prosConsDic

            if let list = productItem.reviewInformation?.reviews{
                self.reviewsProperty.value = list
            }
            if let list = productItem.recommendedAccessories{
                var returnedList = [String]()
                list.forEach({ value in
                    returnedList.append("\(value)")
                })
                self.accessoriesProperty.value = returnedList
            }
        }).disposed(by: disposeBag)

    }
}

