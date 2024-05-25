//
//  MVPattern.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 25.05.2024.
//

import SwiftUI

struct MVPattern: View {
  @EnvironmentObject private var storeModel: StoreModel

  private func populateProducts() async {
    do {
      try await storeModel.populateProducts()
    } catch {
      print(error)
    }
  }

  var body: some View {
    VStack {
      List(storeModel.products) { product in
        Text(product.title).onTapGesture {
          print(product.price)
        }
        Text(product.price as NSNumber, formatter: NumberFormatter.currency)
      }

    }.task {
      await populateProducts()
    }
  }
}

#Preview{
  MVPattern()
    .environmentObject(StoreModel(webService: FakeServices()))
}
