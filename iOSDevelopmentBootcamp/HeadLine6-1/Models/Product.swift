//
//  Product.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 25.05.2024.
//

import Foundation

struct Product: Decodable, Identifiable {
  let id: Int
  let title: String
  let price: Double
}
