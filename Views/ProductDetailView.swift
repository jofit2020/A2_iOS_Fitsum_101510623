//
//  ProductDetailView.swift
//  A2_iOS_Fitsum_101510623
//
//  Created by Serbijos on 09/04/26.
//

import Foundation
import SwiftUI

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(product.name ?? "No Name")
                .font(.largeTitle)
                .bold()

            Group {
                Text("Product ID: \(product.productID ?? "")")
                Text("Provider: \(product.provider ?? "")")
                Text(String(format: "Price: $%.2f", product.price))
            }
            .font(.headline)

            Text("Description")
                .font(.title3)
                .bold()

            Text(product.productDescription ?? "No description")
                .font(.body)

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(14)
        .padding(.horizontal)
    }
}
