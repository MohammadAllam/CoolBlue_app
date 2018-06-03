//
//  CoolBlueAPI.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation
import Moya

enum CoolBlueAPI {
    case discoverProduct(query:String?,page:Int?)
}

extension CoolBlueAPI:TargetType{
    var baseURL: URL {

        return URL(string: CoolBlueAPIConstants.BASE_URL)!
    }

    var path: String {
        switch self {
        case .discoverProduct:
            return CoolBlueAPIConstants.API_DISCOVER_PRODUCT
        }
    }

    var method: Moya.Method {
        switch self {
        case .discoverProduct:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .discoverProduct(let query,let page):
            var paramsDic:[String:Any] = [:]
            paramsDic[CoolBlueAPIConstants.PARAM_API_QUERY] = query
            paramsDic[CoolBlueAPIConstants.PARAM_PAGE_KEY] = page
            return .requestParameters(parameters: paramsDic, encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return [
            CoolBlueAPIConstants.HEADER_ACCEPT_KEY: CoolBlueAPIConstants.HEADER_ACCEPT_VALUE
        ]

    }
}


