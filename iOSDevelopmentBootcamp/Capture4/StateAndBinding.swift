//
//  StateAndBinding.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 12.05.2024.Ÿ||||<<||
//

import SwiftUI

struct StateAndBinding: View {
  @State private var count: Int = 0
  var body: some View {
    VStack {
      Text("\(count)")
        .font(.title)
      Button("Increment") {
        count += 1
      }
      
    }
  }
}

#Preview{
  StateAndBinding()
}
