//
//  View+Extensions.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 13.06.2024.
//

import Foundation
import SwiftUI

extension View {
  func centerHorizontally() -> some View {
    HStack {
      Spacer()
      self
      Spacer()
    }
  }
  @ViewBuilder
  func visible(_ value: Bool) -> some View {
    switch value {
      case true:
        self
      case false:
        EmptyView()
    
    }
  }
}
