//
//  SpecificationSummery.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation

struct SpecificationSum: Codable {
    let name: String?
    let stringValue: String?
    let booleanValue: Bool?

    enum CodingKeys: String, CodingKey {
        case name
        case stringValue
        case booleanValue
    }
}
