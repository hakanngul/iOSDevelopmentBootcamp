//
//  ValidationApp.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 25.05.2024.
//

import SwiftUI



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
      loginFormError.email = "Email is required"
    } else if !email.isValidEmail {
      loginFormError.email = "Email is not in correct format"
    }
    if password.isEmpty {
      loginFormError.password = "Password is required"
    } else if password.count < 3 {
      loginFormError.password = "Password can not be less more than 3"
    }
    return loginFormError.email.isEmpty && loginFormError.password.isEmpty
  }

  var body: some View {
    Form {
      TextField("Email", text: $email)
        .textInputAutocapitalization(.never)
      if !loginFormError.email.isEmpty {
        Text(loginFormError.email).font(.caption)
          .foregroundStyle(.red)
      }

      SecureField("Password", text: $password)
      if !loginFormError.password.isEmpty {
        Text(loginFormError.password)
          .font(.caption)
          .foregroundStyle(.red)
      }
      Button("Login") {
        if isFormValid {
          print("The \(email.description) user logged")
        }
      }//.disabled(!isFormValid)
    }
  }
}

#Preview{
  ValidationApp()
}
