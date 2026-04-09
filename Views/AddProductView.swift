//
//  AddProductView.swift
//  A2_iOS_Fitsum_101510623
//
//  Created by Serbijos on 09/04/26.
//

import SwiftUI

struct AddProductView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ProductViewModel

    @State private var productID = ""
    @State private var name = ""
    @State private var description = ""
    @State private var price = ""
    @State private var provider = ""
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Product")) {
                    TextField("Product ID", text: $productID)
                    TextField("Product Name", text: $name)
                    TextField("Product Description", text: $description, axis: .vertical)
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                    TextField("Provider", text: $provider)
                }
            }
            .navigationTitle("Add Product")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveProduct()
                    }
                }
            }
            .alert("Please fill all fields correctly", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
        }
    }

    private func saveProduct() {
        guard !productID.isEmpty,
              !name.isEmpty,
              !description.isEmpty,
              !provider.isEmpty,
              let priceValue = Double(price) else {
            showAlert = true
            return
        }

        viewModel.addProduct(
            productID: productID,
            name: name,
            description: description,
            price: priceValue,
            provider: provider
        )

        dismiss()
    }
}
