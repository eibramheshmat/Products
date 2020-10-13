//
//  ProductsModel.swift
//  CashU
//
//  Created by Ibram on 10/13/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import Foundation

struct PhotoRequestParams: Codable{
    var apiKey: String
    var method: String
    var format: String
    var nojsoncallback: String
    var text: String
    
    enum CodingKeys: String , CodingKey {
        case apiKey = "api_key"
        case method, format, nojsoncallback, text
    }
}
