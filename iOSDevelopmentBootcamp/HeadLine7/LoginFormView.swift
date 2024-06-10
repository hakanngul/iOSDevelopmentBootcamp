//
//  LoginFormView.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 28.05.2024.
//

import SwiftUI

struct LoginState {
  var email = ""
  var password = ""
  var emailError: LoginError?
  var passwordError: LoginError?

  mutating func clearErrors() {
    emailError = nil
    passwordError = nil
  }

  mutating func isValid() -> Bool {

    clearErrors()

    if email.isEmpty {
      emailError = .emailEmpty
    } else if !email.isValidEmail {
      emailError = .emailInvalid
    }

    if password.isEmpty {
      passwordError = .passwordEmpty
    }

    return emailError == nil && passwordError == nil
  }
}

struct LoginFormView: View {
  @State private var loginState = LoginState()

  var body: some View {
    Form {
      TextField("Email", text: $loginState.email)
        .textInputAutocapitalization(.never)
      if let emailError = loginState.emailError {
        Text(emailError.localizedDescription)
      }

      SecureField("Password", text: $loginState.password)
      if let passwordError = loginState.passwordError {
        Text(passwordError.localizedDescription)
      }

      Button("Login") {
        if loginState.isValid() {
          // perform login
        }
      }
    }
  }
}

#Preview{
  LoginFormView()
}
