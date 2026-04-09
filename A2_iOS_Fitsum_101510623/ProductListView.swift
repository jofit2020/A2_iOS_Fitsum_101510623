import SwiftUI
import CoreData

struct ProductListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.dateAdded, ascending: true)],
        animation: .default
    )
    private var products: FetchedResults<Product>

    var body: some View {
        NavigationStack {
            List {
                ForEach(products, id: \.objectID) { product in
                    VStack(alignment: .leading) {
                        Text(product.name ?? "No Name")
                            .font(.headline)

                        Text(product.productDescription ?? "No Description")
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Products")
        }
    }
}
