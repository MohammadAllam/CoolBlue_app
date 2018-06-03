//
//  ProductServiceMock.swift
//  CoolBlueTests
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation
import RxSwift

@testable import CoolBlue

class ProductServiceMock: ProductServiceType {
    var isDiscoverProductsCalled = false
    var inputQuery = ""
    var inputPage = 0
    var isProductDetailsCalled = false
    var inputProductID = 0

    func discoverProducts(with query: String,page:Int) -> Observable<[Product]>{
        isDiscoverProductsCalled = true
        inputQuery = query
        inputPage = page
        return .just([])
    }

    func productDetails(with productID: Int) -> Observable<Product>{
        isProductDetailsCalled = true
        inputProductID = productID
        return .empty()
    }
}

