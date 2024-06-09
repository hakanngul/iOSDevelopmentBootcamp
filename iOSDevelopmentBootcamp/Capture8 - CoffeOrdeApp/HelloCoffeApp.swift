//
//  HelloCoffeApp.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 8.06.2024.
//

import SwiftUI

struct HelloCoffeApp: View {

  @EnvironmentObject private var model: CoffeModel

  private func populateOrders() async {
    do {
      try await model.populateOrders()
    } catch {
      print(error)
    }
  }

  var body: some View {
    VStack {
      List(model.orders) { order in
        OrderCellView(order: order)
      }
    }.task {
      await populateOrders()
    }
  }
}





#Preview{
  HelloCoffeApp()
    .environmentObject(CoffeModel(webService: WebServiceCoffeOrder()))
}
