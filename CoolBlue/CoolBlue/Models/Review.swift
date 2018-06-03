//
//  Review.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation

struct Review: Codable {
    let reviewId:Int?
    let pros:[String]?
    let cons:[String]?
    let creationDate:String?
    let creatorName:String?
    let description:String?
    let title:String?
    let rating:Float?
    let languageCode:String?

    enum CodingKeys: String, CodingKey {
        case reviewId
        case pros
        case cons
        case creationDate
        case creatorName
        case description
        case title
        case rating
        case languageCode
    }
}
