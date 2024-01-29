//
//  MenuList.swift
//  Little Lemon
//
//  Created by Antonio Lopes on 29/12/23.
//

import Foundation

struct JSONMenu: Codable {
    let menu: [MenuItem]
}


struct MenuItem: Codable {
    let title: String
    let price: String
    let description: String
    let image: String
    let category: String
}
