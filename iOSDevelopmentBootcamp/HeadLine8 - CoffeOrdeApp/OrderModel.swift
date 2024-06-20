//
//  OrderModel.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 8.06.2024.
//

import Foundation

enum CoffeSize: String, CaseIterable, Codable {
  case small, medium, large
}

struct OrderModel: Identifiable, Codable {
  var id: Int?
  var name: String
  var coffeeName: String
  var total: Double
  var size: CoffeSize
}

enum NetworkErrorCoffeApp: Error {
  case badRequest, badUrl, decodingError
}

struct Endpoints {
  static func updateOrder(_ orderId: Int) -> Endpoint {
    return Endpoint(path: "/test/orders/\(orderId)")
  }

  static func deleteOrder(_ orderId: Int) -> Endpoint {
    return Endpoint(path: "/test/orders/\(orderId)")
  }

  static var allOrders: Endpoint {
    return Endpoint(path: "/test/orders")
  }
}

struct Endpoint {
  let path: String
}
