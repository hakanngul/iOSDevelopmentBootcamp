//
//  CoffeModel.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 8.06.2024.
//

import Foundation

@MainActor
class CoffeModel: ObservableObject {

  let webService: WebServiceCoffeOrder
  @Published private(set) var orders: [OrderModel] = []

  init(webService: WebServiceCoffeOrder) {
    self.webService = webService
  }

  func populateOrders() async throws {
    orders = try await webService.getOrders()
  }
}
