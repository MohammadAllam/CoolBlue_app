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
        let reviews: [Review]?
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
    let productText:String?
    let reviewInformation: ReviewInformation?
    let USPs: [String]?
    let pros:[String]?
    let cons:[String]?
    let availabilityState: Int?
    let salesPriceIncVat: Float?
    let listPriceIncVat: Float?
    let salesPriceExVat: Float?
    let productImage: String?
    let productImages: [String]?
    let deliveredWith: [String]?
    let coolbluesChoiceInformationTitle: String?
    let specificationSummary: [SpecificationSum]?
    let promoIcon: PromoIcon?
    let nextDayDelivery: Bool?
    let recommendedAccessories: [Int]?

    enum CodingKeys: String, CodingKey {
        case productId
        case productName
        case productText
        case reviewInformation
        case USPs
        case pros
        case cons
        case availabilityState
        case salesPriceIncVat
        case listPriceIncVat
        case salesPriceExVat
        case productImage
        case productImages
        case deliveredWith
        case coolbluesChoiceInformationTitle
        case specificationSummary
        case promoIcon
        case nextDayDelivery
        case recommendedAccessories
    }
}

