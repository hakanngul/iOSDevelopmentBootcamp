//
//  OrderModel.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 8.06.2024.
//

import Foundation

enum CoffeSize: String, Codable, CaseIterable {
  case small = "Small"
  case medium = "Medium"
  case large = "Large"
}

struct OrderModel: Codable, Identifiable, Hashable {

  var id: Int?
  var name: String
  var coffeeName: String
  var total: Double
  var size: CoffeSize
}
