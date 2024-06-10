//
//  AnotherExampleForState.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 12.05.2024.
//

import SwiftUI

struct AnotherExampleForState: View {
  @State private var isOn: Bool = false
  var body: some View {
    VStack {
      Toggle(
        isOn: $isOn,
        label: {
          Text(isOn ? "ON" : "OFF")
                .foregroundStyle(isOn ? .black : .white)
        }
      ).fixedSize()

    }.frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(isOn ? .green : .black)

  }
}

#Preview{
  AnotherExampleForState()
}
