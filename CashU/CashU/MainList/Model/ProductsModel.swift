//
//  ProductsModel.swift
//  CashU
//
//  Created by Ibram on 10/13/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import Foundation

struct ProductsModel: Codable {
    var data = ProductsData()
}

struct ProductsData: Codable {
    var products = [ProductsObjects]()
}

struct ProductsObjects: Codable {
    var id: Int?
    var nameAr: String?
    var nameEn: String?
    var descriptionAr: String?
    var descriptionEn: String?
    var Links = [ProductLinks]()
    
    enum CodingKeys: String, CodingKey {
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case descriptionAr = "description_ar"
        case descriptionEn = "description_en"
        case id, Links
    }
}

struct ProductLinks: Codable {
    var linkType: String?
    var link: String?
    
    enum CodingKeys: String, CodingKey {
        case linkType = "link_type"
        case link
    }
}

struct Response<T> {
    var data: T?
    var error: String?
}
