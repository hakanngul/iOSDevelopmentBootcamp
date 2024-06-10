//
//  WebService.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 25.05.2024.
//

import Foundation

enum NetworkError2: Error {
  case badURL
  case badRequest
  case decodingError
}

class WebService {

  func getProducts() async throws -> [ProductX] {
    guard let url = URL(string: "https://fakestoreapi.com/products") else {
      throw NetworkError2.badURL
    }

    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw NetworkError2.badRequest
    }

    guard let products = try? JSONDecoder().decode([ProductX].self, from: data) else {
      throw NetworkError2.decodingError
    }

    return products
  }
}
