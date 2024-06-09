//
//  WebServiceCoffeOrder.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 8.06.2024.
//

import Foundation

class WebServiceCoffeOrder {

  func getOrders() async throws -> [OrderModel] {
    // https://island-bramble.glitch.me/orders

    guard let url = URL(string: "https://island-bramble.glitch.me/orders") else {
      throw NetworkError.badUrl
    }

    let (data, response) = try await URLSession.shared.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw NetworkError.badRequest
    }


    guard let orders = try? JSONDecoder().decode([OrderModel].self, from: data) else {
      throw NetworkError.decodingError
    }

    return orders
  }
}
