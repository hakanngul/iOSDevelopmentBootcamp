import Foundation

@MainActor
class CoffeModel: ObservableObject {
  let webService: WebServiceCoffeOrder
  @Published private(set) var orders: [OrderModel] = []

  init(webService: WebServiceCoffeOrder) {
    self.webService = webService
  }

  func orderById(_ id: Int) -> OrderModel? {
    guard let index = orders.firstIndex(where: { $0.id == id }) else {
      return nil
    }
    return orders[index]
  }

  func populateOrders() async throws {
    orders = try await webService.getOrders()
  }

  func placeOrder(_ order: OrderModel) async throws {
    let newOrder = try await webService.placeOrder(order: order)
    orders.append(newOrder)
  }

  func deleteOrder(_ orderId: Int) async throws {
    let deletedOrder = try await webService.deleteOrder(orderId: orderId)
    orders.removeAll { $0.id == deletedOrder.id }
  }

  func updateOrder(_ order: OrderModel) async throws {
    let updatedOrder = try await webService.updateOrder(order)
    if let index = orders.firstIndex(where: { $0.id == updatedOrder.id }) {
      orders[index] = updatedOrder
    }
  }
}
