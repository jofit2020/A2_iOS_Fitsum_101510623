//
//  SampleDataSeeder.swift
//  A2_iOS_Fitsum_101510623
//
//  Created by Serbijos on 09/04/26.
//

import Foundation
import CoreData

struct SampleDataSeeder {
    static func seedIfNeeded(context: NSManagedObjectContext) {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.fetchLimit = 1

        do {
            let count = try context.count(for: request)
            if count > 0 {
                return
            }

            let products: [(String, String, String, Double, String)] = [
                ("P001", "iPhone 15", "Apple smartphone with advanced camera and smooth performance.", 999.99, "Apple"),
                ("P002", "MacBook Air", "Lightweight laptop with excellent battery life.", 1299.99, "Apple"),
                ("P003", "AirPods Pro", "Wireless earbuds with noise cancellation.", 249.99, "Apple"),
                ("P004", "Galaxy S24", "Samsung flagship smartphone with vibrant display.", 899.99, "Samsung"),
                ("P005", "Dell XPS 13", "Compact premium laptop for students and professionals.", 1199.99, "Dell"),
                ("P006", "Sony WH-1000XM5", "Over-ear headphones with premium sound.", 399.99, "Sony"),
                ("P007", "iPad Air", "Portable tablet for study, work, and entertainment.", 699.99, "Apple"),
                ("P008", "Logitech MX Master 3S", "Advanced wireless productivity mouse.", 99.99, "Logitech"),
                ("P009", "Canon EOS R50", "Mirrorless camera for photography and video.", 849.99, "Canon"),
                ("P010", "Kindle Paperwhite", "E-reader with glare-free display and long battery life.", 159.99, "Amazon")
            ]

            for item in products {
                let product = Product(context: context)
                product.id = UUID()
                product.productID = item.0
                product.name = item.1
                product.productDescription = item.2
                product.price = item.3
                product.provider = item.4
            }

            try context.save()
        } catch {
            print("Seeding error: \(error.localizedDescription)")
        }
    }
}
