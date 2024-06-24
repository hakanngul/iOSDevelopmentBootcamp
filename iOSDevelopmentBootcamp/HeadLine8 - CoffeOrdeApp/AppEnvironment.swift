//
//  AppEnvironment.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 10.06.2024.
//

import Foundation

enum EndpointsX {
  case allOrders
  case placeOrder
  case deleteOrder(Int)
  case updateOrder(Int)

  var path: String {
    switch self {
    case .allOrders:
      return "/test/orders"
    case .placeOrder:
      return "/test/new-order"
    case .deleteOrder(let orderId):
      return "/test/orders/\(orderId)"
    case .updateOrder(let orderId):
      return "/test/orders/\(orderId)"
    }
  }
}

struct Configuration {
  lazy var environment: AppEnvironment = {
    guard let env = ProcessInfo.processInfo.environment["ENV"] else {
      return AppEnvironment.test
    }

    if env == "TEST" {
      print("ENV is => TEST")
      return AppEnvironment.test
    }

    print("ENV is => DEV")
    return AppEnvironment.test

  }()
}

enum AppEnvironment: String {
  case dev
  case test

  var baseUrl: URL {
    switch self {
    case .dev:
      return URL(string: "https://island-bramble.glitch.me")!

    case .test:
      return URL(string: "https://island-bramble.glitch.me/test")!

    }
  }
}
