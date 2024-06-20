//
//  HelloCoffeApp.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 8.06.2024.
//

import SwiftUI

struct HelloCoffeApp: View {

  @EnvironmentObject private var model: CoffeModel
  @State private var isPresented: Bool = false
  @State private var isClicked: Bool = false

  private func populateOrders() async {
    do {
      try await model.populateOrders()
    } catch {
      print(error)
    }
  }

  private func deleteOrder(_ indexSet: IndexSet) {
    Task {
      await withThrowingTaskGroup(of: Void.self) { group in
        for index in indexSet {
          group.addTask {
            let order = await model.orders[index]
            guard let orderId = order.id else {
              return
            }
            do {
              try await model.deleteOrder(orderId)
            } catch {
              print(error)
            }
          }
        }
      }
    }
  }

  var body: some View {
    NavigationStack {

      VStack {
        if model.orders.isEmpty {
          Text("No orders available!").accessibilityIdentifier("noOrdersText")
            .centerHorizontally()
        }
        List {
          ForEach(model.orders) { order in
            NavigationLink(value: order.id) {
              OrderCellView(order: order)
            }
          }.onDelete(perform: deleteOrder)
        }.accessibilityIdentifier("orderList")
      }
      .navigationDestination(
        for: Int.self,
        destination: { orderId in
          OrderDetailView(orderId: orderId)
        }
      )
      .task {
        await populateOrders()
      }
      .sheet(
        isPresented: $isPresented,
        content: {
          AddCoffeView()
        }
      )
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Add new order") {
            isPresented = true
          }.accessibilityIdentifier("addNewOrderButton")
        }
      }
    }
  }
}

struct HelloCoffe_Previews: PreviewProvider {
  static var previews: some View {
    var config = Configuration()
    HelloCoffeApp()
      .environmentObject(
        CoffeModel(webService: WebServiceCoffeOrder(baseURL: config.environment.baseUrl)))
  }
}
