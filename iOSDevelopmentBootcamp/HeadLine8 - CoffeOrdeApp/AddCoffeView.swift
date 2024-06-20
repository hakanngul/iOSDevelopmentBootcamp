//
//  AddCoffeView.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 13.06.2024.
//

import SwiftUI

struct AddCoffeErrors {
  var name: String = ""
  var coffeeName: String = ""
  var price: String = ""

}

struct AddCoffeView: View {
  var order: OrderModel? = nil
  @State private var name = ""
  @State private var coffeeName = ""
  @State private var price = ""
  @State private var coffeeSize: CoffeSize = .medium
  @State private var errors: AddCoffeErrors = AddCoffeErrors()
  @Environment(\.dismiss) private var dismiss

  @EnvironmentObject private var model: CoffeModel

  var isValid: Bool {
    errors = AddCoffeErrors()

    if name.isEmpty {
      errors.name = "Name cannot be empty!"
    }
    if coffeeName.isEmpty {
      errors.coffeeName = "Coffee name cannot be empty!"
    }

    if price.isEmpty {
      errors.price = "Price cannot be empty!"
    } else if !price.isNumeric {
      errors.price = "Price needs to be a number"
    } else if price.isLessThan(1) {
      errors.price = "Price needs to be more than 0"
    }
    return errors.name.isEmpty && errors.price.isEmpty && errors.coffeeName.isEmpty
  }

  private func placeOrder(_ order: OrderModel) async {
    let order = OrderModel(
      name: name, coffeeName: coffeeName, total: Double(price) ?? 0, size: coffeeSize)
    do {
      try await model.placeOrder(order)
    } catch {
      print(error)
    }
  }

  private func saveOrUpdate() async {
    if let order {
      var editOrder = order
      editOrder.name = name
      editOrder.total = Double(price) ?? 0.0
      editOrder.coffeeName = coffeeName
      editOrder.size = coffeeSize
      await updateOrder(editOrder)
    } else {
      let order = OrderModel(
        name: name, coffeeName: coffeeName, total: Double(price) ?? 0.0, size: coffeeSize)
      await placeOrder(order)
    }
    dismiss()
  }

  private func updateOrder(_ order: OrderModel) async {
    do {
      try await model.updateOrder(order)
    } catch {
      print(error)
    }
  }

  private func populateExistingOrder() {
    if let order = order {
      name = order.name
      coffeeName = order.coffeeName
      price = String(order.total)
      coffeeSize = order.size
    }
  }

  var body: some View {

    NavigationStack {
      Form {
        TextField("Name", text: $name)
          .accessibilityIdentifier("name")
        Text(errors.name).visible(errors.name.isNotEmpty)
          .font(.caption)
          .foregroundStyle(.red)
        TextField("Coffee name", text: $coffeeName)
          .accessibilityIdentifier("coffeeName")
        Text(errors.coffeeName).visible(errors.coffeeName.isNotEmpty)
          .font(.caption)
          .foregroundStyle(.red)
        TextField("Price", text: $price)
          .accessibilityIdentifier("price")
        Text(errors.price).visible(errors.price.isNotEmpty)
          .font(.caption)
          .foregroundStyle(.red)
        Picker("Select size", selection: $coffeeSize) {
          ForEach(CoffeSize.allCases, id: \.rawValue) { size in
            Text(size.rawValue).tag(size)
          }
        }.pickerStyle(.segmented)

        Button(order != nil ? "Update Order" : "Place Order") {
          if isValid {
            Task {
              await saveOrUpdate()
            }
          }
        }
        .accessibility(identifier: "orderButton")
        .centerHorizontally()
      }.navigationTitle(order != nil ? "Update Order" : "Add Coffee")
        .onAppear {
          populateExistingOrder()
        }
    }
  }
}

#Preview{
  AddCoffeView()
}
