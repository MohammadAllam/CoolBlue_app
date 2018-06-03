//
//  ProductService.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class ProductService:ProductServiceType {

    private var service: MoyaProvider<CoolBlueAPI>

    init(service: MoyaProvider<CoolBlueAPI> = MoyaProvider<CoolBlueAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])) {
        self.service = service
    }

    func discoverProducts(with query: String,page:Int) -> Observable<[Product]> {

        return service.rx
            .request(.discoverProduct(query: query, page: page))
            .debug("ProductService : discoverProducts")
            .filterSuccessfulStatusCodes()
            .map([Product].self, atKeyPath:"products")
            .asObservable()
            .catchError { error in
                return .just([])
        }
    }
}
