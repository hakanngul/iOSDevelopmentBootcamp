//
//  StoreModel.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 25.05.2024.
//

import Foundation

@MainActor
class StoreModel: ObservableObject {
  let webService: FakeServices
  @Published var products: [Product] = []

  init(webService: FakeServices) {
    self.webService = webService
  }

  func populateProducts() async throws {
    do {
      products = try await webService.getProducts()
    } catch {
      print(error)
    }
  }
}
