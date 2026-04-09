import SwiftUI
import CoreData
import Combine

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        ProductBrowserContainer(context: viewContext)
    }
}

struct ProductBrowserContainer: View {
    @StateObject private var viewModel: ProductViewModel
    @State private var showAddSheet = false

    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: ProductViewModel(context: context))
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                searchBar

                if let product = viewModel.currentProduct {
                    ProductDetailView(product: product)
                } else {
                    Text("No products found")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding()
                }

                navigationButtons

                NavigationLink(destination: ProductListView(viewModel: viewModel)) {
                    Text("View Full Product List")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Button {
                    showAddSheet = true
                } label: {
                    Text("Add New Product")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Text("Fitsum Asgedom - Student ID: 101510623")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.top, 8)

                Spacer()
            }
            .navigationTitle("Product Browser")
            .sheet(isPresented: $showAddSheet) {
                AddProductView(viewModel: viewModel)
            }
        }
    }

    private var searchBar: some View {
        TextField("Search by product name or description", text: $viewModel.searchText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
    }

    private var navigationButtons: some View {
        HStack(spacing: 20) {
            Button("Previous") {
                viewModel.previousProduct()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)

           
        }
        .padding(.horizontal)
    }
}
