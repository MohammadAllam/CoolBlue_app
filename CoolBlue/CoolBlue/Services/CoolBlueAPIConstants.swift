//
//  CoolBlueAPIConstants.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation

struct CoolBlueAPIConstants {
    // Base URL
    static let BASE_URL = "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/ios-assignment"
    // APIs
    static let API_DISCOVER_PRODUCT = "/search"
    static let API_PRODUCT_DETAILS = "/product/"
    // Headers
    static let HEADER_ACCEPT_KEY = "Accept"
    static let HEADER_ACCEPT_VALUE = "application/json"
    // Parameters
    static let PARAM_API_QUERY = "query"
    static let PARAM_PAGE_KEY = "page"
}
