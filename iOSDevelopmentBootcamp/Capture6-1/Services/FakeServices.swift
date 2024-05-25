//
//  FakeServices.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 25.05.2024.
//

import Foundation

enum PNetworkError: Error {
  case badURL
  case badRequest
  case badData
}

class FakeServices {

  func getProducts() async throws -> [Product] {
    guard let url = URL(string: "https://fakestoreapi.com/products") else {
      throw PNetworkError.badURL
    }

    let (data, response) = try await URLSession.shared.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw PNetworkError.badRequest
    }

    let products = try JSONDecoder().decode([Product].self, from: data)
    return products
  }
}
