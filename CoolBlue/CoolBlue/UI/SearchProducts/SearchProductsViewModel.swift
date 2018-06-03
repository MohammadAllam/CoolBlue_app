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
    private var productsProperty = Variable<[String]>([])
    private var productsList = [String]([])

    // MARK: Init
    init(disposeBag:DisposeBag) {

        query.asObservable()
            .subscribe(onNext: { [unowned self] queryString in
                guard !queryString.isEmpty else {
                    self.productsProperty.value = []
                    return
                }
                self.productsProperty.value = ["1",
                                               "2",
                                               "3",
                                               "4",]
            })
            .disposed(by: disposeBag)

    }
}
