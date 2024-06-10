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
//
//#Preview{
//  var config = Configuration()
//  HelloCoffeApp()
//    .environmentObject(
//      CoffeModel(webService: WebServiceCoffeOrder(baseURL: config.environment.baseUrl)))
//}

struct HelloCoffe_Previews: PreviewProvider {
  static var previews: some View {
    var config = Configuration()
    HelloCoffeApp()
      .environmentObject(CoffeModel(webService: WebServiceCoffeOrder(baseURL: config.environment.baseUrl)))
  }
}
