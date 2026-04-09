//
//  ProductViewModel.swift
//  A2_iOS_Fitsum_101510623
//
//  Created by Serbijos on 09/04/26.
//

import Foundation
import CoreData
import Combine

final class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var filteredProducts: [Product] = []
    @Published var searchText: String = "" {
        didSet {
            searchProducts()
        }
    }
    @Published var currentIndex: Int = 0

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchProducts()
    }

    func fetchProducts() {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "productID", ascending: true)]

        do {
            products = try context.fetch(request)
            filteredProducts = products

            if currentIndex >= filteredProducts.count {
                currentIndex = 0
            }
        } catch {
            print("Fetch error: \(error.localizedDescription)")
        }
    }

    func searchProducts() {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            filteredProducts = products
        } else {
            let text = searchText.lowercased()
            filteredProducts = products.filter {
                ($0.name ?? "").lowercased().contains(text) ||
                ($0.productDescription ?? "").lowercased().contains(text)
            }
        }

        currentIndex = 0
    }

    func addProduct(productID: String, name: String, description: String, price: Double, provider: String) {
        let product = Product(context: context)
        product.id = UUID()
        product.productID = productID
        product.name = name
        product.productDescription = description
        product.price = price
        product.provider = provider

        do {
            try context.save()
            fetchProducts()
        } catch {
            print("Save error: \(error.localizedDescription)")
        }
    }

    func nextProduct() {
        guard !filteredProducts.isEmpty else { return }
        if currentIndex < filteredProducts.count - 1 {
            currentIndex += 1
        }
    }

    func previousProduct() {
        guard !filteredProducts.isEmpty else { return }
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }

    var currentProduct: Product? {
        guard !filteredProducts.isEmpty,
              currentIndex >= 0,
              currentIndex < filteredProducts.count else {
            return nil
        }
        return filteredProducts[currentIndex]
    }
}
