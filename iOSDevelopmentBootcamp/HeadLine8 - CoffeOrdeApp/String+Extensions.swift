//
//  String+Extensions.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 13.06.2024.
//

import Foundation

extension String {
  var isNumeric: Bool {
    Double(self) != nil
  }
  
  var isNotEmpty: Bool {
    !self.isEmpty
  }
  
  func isLessThan(_ number: Double) -> Bool {
    if !self.isNumeric {
      return false
    }
    guard let value = Double(self) else { return false}
    return value < number
  }
  
  var isValidEmail: Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return predicate.evaluate(with: self)
  }
}
