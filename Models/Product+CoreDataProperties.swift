//
//  Product+CoreDataProperties.swift
//  A2_iOS_Fitsum_101510623
//
//  Created by Serbijos on 09/04/26.
//

import Foundation
import CoreData

extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var productID: String?
    @NSManaged public var name: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var price: Double
    @NSManaged public var provider: String?
}
