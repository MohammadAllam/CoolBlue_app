//
//  SearchProductsViewModel.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchViewModelInput{
    /// Updated when the entered search text chnages
    var query: BehaviorSubject<String> { get }

    /// Call when the bottom of the list is reached
    var loadMore: BehaviorSubject<Bool> { get }

    /// Call when new query is entered
    func newQuery()
}

protocol SearchViewModelOutput{
    /// Emits an array of products for the tableview
    var products: Observable<[Product]>! { get }

    /// Emits a boolean when executing search query.
    var isNewQuery: Observable<Bool>! { get }
}

protocol SearchViewModelType {
    var inputs: SearchViewModelInput { get }
    var outputs: SearchViewModelOutput { get }
}

class SearchViewModel: SearchViewModelType,
    SearchViewModelInput,
SearchViewModelOutput{

    // MARK: Inputs & Outputs
    var inputs: SearchViewModelInput { return self }
    var outputs: SearchViewModelOutput { return self }

    // MARK: Input
    let query = BehaviorSubject<String>(value: "")
    let loadMore = BehaviorSubject<Bool>(value: false)

    func newQuery(){
        newQueryProperty.onNext(true)
    }

    // MARK: Output
    var products: Observable<[Product]>!
    var isNewQuery: Observable<Bool>!

    // MARK: Private
    private var productService:ProductServiceType
    private var productsList = [Product]([])
    private let newQueryProperty = BehaviorSubject<Bool>(value: true)

    // MARK: Init
    init(inputService:ProductServiceType = ProductService()) {

        productService = inputService

        var currentPageIndex = 1
        isNewQuery = newQueryProperty.asObservable()

        let searchRequest = Observable
            .combineLatest(isNewQuery, query)
            .flatMapLatest { isNewQuery, query -> Observable<[Product]> in
                guard query.count > 0 else { return .empty() }
                guard isNewQuery else { return .empty() }
                return self.productService
                    .discoverProducts(with: query,
                                      page: 1)
                    .asObservable()
            }
            .do (onNext: { [unowned self] _ in
                self.productsList = []
                currentPageIndex = 1
            })

        let loadMoreRequest = Observable
            .combineLatest(loadMore, query)
            .flatMapLatest { [unowned self] loadMore, query -> Observable<[Product]> in
                guard query.count > 0 else { return .empty() }
                guard loadMore else { return .empty() }
                currentPageIndex += 1
                return self.productService
                    .discoverProducts(with: query,
                                      page: currentPageIndex)
                    .asObservable()
        }

        products = Observable
            .merge(searchRequest, loadMoreRequest)
            .map({ [unowned self] products -> [Product] in
                products.forEach { [unowned self] product in
                    self.productsList.append(product)
                }
                self.newQueryProperty.onNext(false)
                return self.productsList
            })
            .catchError({ [unowned self] error in
                //                self.alertAction.execute(error.localizedDescription)
                self.newQueryProperty.onNext(false)
                return Observable.just(self.productsList)
            })

    }

    func getProduct(atIndex index:Int) -> Product{

        return productsList[index]
    }

    func getCellViewModel(with product:Product) -> ProductCellViewModel{

        // Formatting the values to the desired string format
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // Applying the format to the new and old prices
        var oldPriceString:String?
        if let oldPrice = product.listPriceIncVat {

            oldPriceString = currencyFormatter.string(from: NSNumber(value: oldPrice))
        }
        let newPriceString = currencyFormatter.string(from: NSNumber(value: product.salesPriceIncVat ?? 0.0)) ?? "0,0"
        // Reformatting the USPs
        let displayedUSPs = product.USPs?.map({ oldText -> String in
            return "•  \(oldText) end of text"
        })

        return ProductCellViewModel(coolBlueTitle: product.coolbluesChoiceInformationTitle,
                                    title: product.productName ?? "",
                                    reviewAvg: Double(product.reviewInformation?.reviewSummary?.reviewAverage ?? 0.0)/2,
                                    reviewCount: String(product.reviewInformation?.reviewSummary?.reviewCount ?? 0),
                                    usp: displayedUSPs ?? [],
                                    oldPrice: oldPriceString,
                                    newPrice: newPriceString,
                                    availabilityFlag: product.availabilityState ?? 2,
                                    thumbnail: product.productImage,
                                    promoIconName: product.promoIcon?.type,
                                    promoIconText: product.promoIcon?.text,
                                    nextDayDeliveryFlag: product.nextDayDelivery ?? false)
    }

}

struct ProductCellViewModel{
    let coolBlueTitle:String?
    let title:String
    let reviewAvg:Double
    let reviewCount:String
    let usp:[String]
    let oldPrice:String?
    let newPrice:String
    let availabilityFlag:Int
    let thumbnail:String?
    let promoIconName:String?
    let promoIconText:String?
    let nextDayDeliveryFlag:Bool
}
