//
//  LoginView.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 28.05.2024.
//

import SwiftUI

struct LoginView: View {
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var errors: [LoginError] = []

  var isValid: Bool {
    errors.removeAll()

    if email.isEmpty {
      errors.append(.emailEmpty)
    } else if !email.isValidEmail {
      errors.append(.emailInvalid)
    }

    if password.isEmpty {
      errors.append(.passwordEmpty)
    }

    return errors.isEmpty
  }

  var body: some View {
    Form {
      TextField("Email", text: $email).textInputAutocapitalization(.never)
      SecureField("Password", text: $password)
      Button("Login") {
        if isValid {
          print("Submit the form")
        }
      }

      ValidationSummaryView(errors: errors)
    }
  }
}

#Preview{
  LoginView()
}
