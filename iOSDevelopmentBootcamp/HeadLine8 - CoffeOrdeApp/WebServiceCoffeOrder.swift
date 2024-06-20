import Foundation

class WebServiceCoffeOrder {
  private var baseURL: URL

  init(baseURL: URL) {
    self.baseURL = URL(string: "https://island-bramble.glitch.me/test")!
  }

  func updateOrder(_ order: OrderModel) async throws -> OrderModel {
    guard let orderId = order.id else {
      throw NetworkError.badRequest
    }
    guard let url = URL(string: Endpoints.updateOrder(orderId).path, relativeTo: baseURL) else {
      throw NetworkError.badUrl
    }

    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try JSONEncoder().encode(order)

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw NetworkError.badRequest
    }

    guard let updatedOrder = try? JSONDecoder().decode(OrderModel.self, from: data) else {
      throw NetworkError.decodingError
    }

    return updatedOrder
  }

  func placeOrder(order: OrderModel) async throws -> OrderModel {
    guard let url = URL(string: "\(self.baseURL)/new-order") else {
      throw NetworkError.badUrl
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try JSONEncoder().encode(order)

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw NetworkError.badRequest
    }

    guard let newOrder = try? JSONDecoder().decode(OrderModel.self, from: data) else {
      throw NetworkError.decodingError
    }

    return newOrder
  }

  func deleteOrder(orderId: Int) async throws -> OrderModel {
    guard let url = URL(string: Endpoints.deleteOrder(orderId).path, relativeTo: self.baseURL)
    else {
      throw NetworkError.badUrl
    }

    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw NetworkError.badRequest
    }

    guard let deletedOrder = try? JSONDecoder().decode(OrderModel.self, from: data) else {
      throw NetworkError.decodingError
    }

    return deletedOrder
  }

  func getOrders() async throws -> [OrderModel] {
    guard let url = URL(string: Endpoints.allOrders.path, relativeTo: self.baseURL) else {
      throw NetworkError.badUrl
    }

    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw NetworkError.badRequest
    }
    print("********")
    print(data)

    guard let orders = try? JSONDecoder().decode([OrderModel].self, from: data) else {
      print("Get Orders Decoding errors")
      throw NetworkError.decodingError
    }

    return orders
  }
}
