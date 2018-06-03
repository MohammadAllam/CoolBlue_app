//
//  ProductServiceType.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation
import RxSwift

protocol ProductServiceType {
    func discoverProducts(with query: String,page:Int) -> Observable<[Product]>
}
