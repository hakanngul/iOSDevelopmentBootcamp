//
//  ValidationApp.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 25.05.2024.
//

import SwiftUI

struct LoginFormError {
  var eamil: String = ""
  var password: String = ""
}

struct ValidationApp: View {
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var loginFormError = LoginFormError()

  private func clearForm() {
    loginFormError = LoginFormError()
  }

  var isFormValid: Bool {
    clearForm()

    if email.isEmpty {
      loginFormError.eamil = "Email is required"
    } else if !email.isValidEmail {
      loginFormError.eamil = "Email is not in correct format"
    }
    if password.isEmpty {
      loginFormError.password = "Password is required"
    } else if password.count < 3 {
      loginFormError.password = "Password can not be less more than 3"
    }
    return loginFormError.eamil.isEmpty && loginFormError.password.isEmpty
  }

  var body: some View {
    Form {
      TextField("Email", text: $email)
      TextField("Password", text: $password)
      Button("Login") {
        print("Email is valid and the user is logged : \(email)")
      }.disabled(!isFormValid)
    }
  }
}

#Preview{
  ValidationApp()
}
