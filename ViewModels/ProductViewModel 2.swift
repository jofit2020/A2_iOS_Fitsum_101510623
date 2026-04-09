//
//  ProductViewModel 2.swift
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

            if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                filteredProducts = products
            } else {
                let text = searchText.lowercased()
                filteredProducts = products.filter {
                    ($0.name ?? "").lowercased().contains(text) ||
                    ($0.productDescription ?? "").lowercased().contains(text)
                }
            }

            if filteredProducts.isEmpty {
                currentIndex = 0
            } else if currentIndex >= filteredProducts.count {
                currentIndex = filteredProducts.count - 1
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
            if !filteredProducts.isEmpty {
                currentIndex = filteredProducts.count - 1
            }
        } catch {
            print("Save error: \(error.localizedDescription)")
        }
    }

    func nextProduct() {
        guard currentIndex < filteredProducts.count - 1 else { return }
        currentIndex += 1
    }

    func previousProduct() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
    }

    var currentProduct: Product? {
        guard !filteredProducts.isEmpty,
              currentIndex >= 0,
              currentIndex < filteredProducts.count else {
            return nil
        }
        return filteredProducts[currentIndex]
    }

    var canGoPrevious: Bool {
        currentIndex > 0
    }

    var canGoNext: Bool {
        currentIndex < filteredProducts.count - 1
    }
}
