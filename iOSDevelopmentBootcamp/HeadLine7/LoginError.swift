//
//  LoginFormError.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 26.05.2024.
//

import Foundation

struct LoginFormError {
  var email: String = ""
  var password: String = ""
}

enum LoginError: LocalizedError, Identifiable {
  case emailEmpty
  case emailInvalid
  case passwordEmpty

  var id: Int {
    hashValue
  }

  var errorDescription: String? {
    switch self {
    case .emailEmpty: return "Email cannot be empty!"
    case .emailInvalid: return "Email is not in correct format"
    case .passwordEmpty: return "Password cannot be empty"
    }
  }
}
