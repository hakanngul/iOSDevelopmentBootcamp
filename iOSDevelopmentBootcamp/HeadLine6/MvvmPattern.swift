//
//  MvvmPattern.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 25.05.2024.
//

import SwiftUI

struct MvvmPattern: View {
    @StateObject private var vm = ProductListViewModel(webService: WebService())
    
    var body: some View {
        List(vm.products) {product in
            Text(product.title)
        }.task {
            await vm.populateProducts()
        }
    }
}

#Preview {
    MvvmPattern()
}
  
