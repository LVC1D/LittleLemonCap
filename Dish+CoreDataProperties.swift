//
//  Dish+CoreDataProperties.swift
//  LittleLemonCap
//
//  Created by Illia Berezovskyi on 16/10/2023.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }
    
    @NSManaged public var price: String
    @NSManaged public var image: String
    @NSManaged public var title: String
    @NSManaged public var category: String
    @NSManaged public var descriptionDish: String

}

extension Dish : Identifiable {

}
