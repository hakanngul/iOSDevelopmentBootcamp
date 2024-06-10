//
//  LocalizedError+Extensions.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 28.05.2024.
//

import Foundation

extension LocalizedError {
  var id: Int {
    localizedDescription.hashValue
  }
}
