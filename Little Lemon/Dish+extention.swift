//
//  MenuList+extention.swift
//  Little Lemon
//
//  Created by Antonio Lopes on 29/12/23.
//

import Foundation
import CoreData

extension Array where Iterator.Element == MenuItem {
    static func createDishes(context: NSManagedObjectContext) {
        
        (self as! Array<MenuItem>).forEach {menu in
            
            let dish = Dish(context: context)
            dish.title = menu.title
            dish.descriptions = menu.description
            dish.image = menu.image
            if let price = Float(menu.price) {
                dish.price = price
            }
            dish.category = menu.category
        }
    }
}
