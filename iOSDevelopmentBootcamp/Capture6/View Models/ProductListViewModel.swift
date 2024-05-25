//
//  ProductListViewModel.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 25.05.2024.
//

import Foundation

@MainActor
class ProductListViewModel: ObservableObject {

    @Published var products :[ProductViewModel] = []
    
    let webService: WebService
    init(webService: WebService) {
        self.webService = webService
    }
    func populateProducts() async {
        do {
            let products = try await webService.getProducts()
            self.products = products.map(ProductViewModel.init)
        } catch {
            print(error)
        }
        
    }
}

struct ProductViewModel : Identifiable{
    private var product: ProductX
    init(product: ProductX) {
        self.product = product
    }
    var id: Int {
        product.id
    }
    
    var title: String {
        product.title
    }
    
    var price: Double {
        product.price
    }
    
}
