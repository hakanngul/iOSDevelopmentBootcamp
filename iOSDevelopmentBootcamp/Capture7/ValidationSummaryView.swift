//
//  ValidationSummaryView.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 28.05.2024.
//

import SwiftUI

struct ValidationSummaryView: View {
  let errors: [LocalizedError]
  var body: some View {
    ForEach(errors, id: \.id) { error in
      Text(error.localizedDescription)
    }
  }
}

#Preview{
  ValidationSummaryView(errors: [])
}
