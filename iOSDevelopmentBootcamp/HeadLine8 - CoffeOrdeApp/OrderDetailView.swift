//
//  OrderDetailView.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 19.06.2024.
//

import SwiftUI

struct OrderDetailView: View {
  let orderId: Int
  @EnvironmentObject private var model: CoffeModel
  @Environment(\.dismiss) private var dismiss
  @State private var isPresented: Bool = false

  private func deleteOrder() async {
    do {
      try await model.deleteOrder(orderId)
      dismiss()
    } catch {
      print(error)
    }
  }

  var body: some View {
    VStack {
      if let order = model.orderById(orderId) {
        VStack(alignment: .leading, spacing: 10) {
          Text(order.coffeeName)
            .font(.title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibilityIdentifier("coffeeNameText")

          Text(order.size.rawValue).opacity(0.5)
          Text(order.total as NSNumber, formatter: NumberFormatter.currency)
          HStack {
            Spacer()
            Button("Delete Order", role: .destructive) {
              Task {
                await deleteOrder()
              }
            }.accessibilityIdentifier("deleteOrderButton")
            Button("Edit Order") {
              isPresented = true
            }.accessibilityIdentifier("editOrderButton")
            Spacer()
          }
        }.sheet(
          isPresented: $isPresented,
          content: {
            AddCoffeView(order: order)
          })

      }
      Spacer()
    }
    .padding()
  }
}

struct OrderDetailView_Previews: PreviewProvider {
  static var previews: some View {
    var config = Configuration()
    OrderDetailView(orderId: 1).environmentObject(
      CoffeModel(webService: WebServiceCoffeOrder(baseURL: config.environment.baseUrl)))
  }
}

//#Preview {
//  var config = Configuration()
//  OrderDetailView(orderId: 1).environmentObject(CoffeModel(webService: WebServiceCoffeOrder(baseURL: config.environment.baseUrl)))
//}
