//
//  Brands.swift
//  RadioFrance
//
//  Created by Loic D on 15/11/2022.
//

import Foundation

struct Decode_Brands: Codable {
    let data: DataClass
    
    struct DataClass: Codable {
        let brands: [Brand]
    }

    struct Brand: Codable {
        let id, title: String
        let baseline: String?
    }

}
