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
}

protocol SearchViewModelOutput{
    /// Emits an array of products for the tableview
    var products: Observable<[String]>! { get }
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

    // MARK: Output
    var products: Observable<[String]>!{
        return productsProperty.asObservable()
    }

    // MARK: Private
    private var productService:ProductServiceType
    private var productsProperty = Variable<[String]>([])
    private var productsList = [String]([])

    // MARK: Init
    init(inputService:ProductServiceType = ProductService(),
        disposeBag:DisposeBag) {

        productService = inputService

        query.asObservable()
            .subscribe(onNext: { [unowned self] queryString in
                guard !queryString.isEmpty else {
                    self.productsProperty.value = []
                    return
                }
                self.productService.discoverProducts(with: queryString,
                                                                     page: 1)
                    .subscribe(onNext: { (products) in
                        var tempList = [String]()
                        products.forEach({ productObj in
                            if let name = productObj.productName{
                                tempList.append(name)
                            }
                        })
                        self.productsProperty.value = tempList
                    })
                .disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)

    }
}
