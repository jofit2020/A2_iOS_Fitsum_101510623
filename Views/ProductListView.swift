//
//  ProductListView.swift
//  A2_iOS_Fitsum_101510623
//
//  Created by Serbijos on 09/04/26.
//

import SwiftUI
import CoreData

struct ProductListView: View {
    let products: [Product]

    var body: some View {
        List(products,id: \.objectID)
        { product in
            VStack(alignment: .leading, spacing: 6) {
                Text(product.name ?? "No Name")
                    .font(.headline)

                Text(product.productDescription ?? "No Description")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("All Products")
    }
}
