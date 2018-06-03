//
//  Product.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation

struct Product: Codable {

    struct ReviewInformation: Codable {
        let reviews: [String]?
        let reviewSummary: ReviewSummery?

        enum CodingKeys: String, CodingKey {
            case reviews
            case reviewSummary
        }
    }

    struct ReviewSummery: Codable {
        let reviewCount:Int?
        let reviewAverage:Float?

        enum CodingKeys: String, CodingKey {
            case reviewCount
            case reviewAverage
        }
    }

    struct PromoIcon: Codable {
        let text: String?
        let type: String?

        enum CodingKeys: String, CodingKey {
            case text
            case type
        }
    }


    let productId:Int?
    let productName:String?
    let reviewInformation: ReviewInformation?
    let USPs: [String]?
    let availabilityState: Int?
    let salesPriceIncVat: Float?
    let listPriceIncVat: Float?
    let salesPriceExVat: Float?
    let productImage: String?
    let promoIcon: PromoIcon?
    let nextDayDelivery: Bool?

    enum CodingKeys: String, CodingKey {
        case productId
        case productName
        case reviewInformation
        case USPs
        case availabilityState
        case salesPriceIncVat
        case listPriceIncVat
        case salesPriceExVat
        case productImage
        case promoIcon
        case nextDayDelivery
    }
}
