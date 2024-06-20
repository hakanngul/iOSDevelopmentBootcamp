//
//  CoffeAppE2ETests.swift
//  CoffeAppE2ETests
//
//  Created by Hakan Gül on 13.06.2024.
//

import XCTest

final class when_updating_an_existing_order: XCTestCase {
  private var app: XCUIApplication!
  func test_should_update_order_successfully() {
    let collectionViewsQuery = app.collectionViews
    let orderList = collectionViewsQuery["orderList"]

    orderList.buttons["orderNameText-coffeeNameAndSizeText-coffeePriceText"]
      .tap()

    let editOrderButton = app.buttons["editOrderButton"]
    let nameTextField = collectionViewsQuery.textFields["name"]
    let coffeeNameTextField = collectionViewsQuery.textFields["coffeeName"]
    let priceTextField = collectionViewsQuery.textFields["price"]

    let _ = editOrderButton.waitForExistence(timeout: 2.0)
    editOrderButton.tap()

    let _ = nameTextField.waitForExistence(timeout: 2.0)
    nameTextField.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    nameTextField.typeText("John Edit")

    let _ = coffeeNameTextField.waitForExistence(timeout: 2.0)
    coffeeNameTextField.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    coffeeNameTextField.typeText("Hot Coffee Edit")

    let _ = priceTextField.waitForExistence(timeout: 2.0)
    priceTextField.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    priceTextField.typeText("12.50")

    collectionViewsQuery.buttons["orderButton"].tap()

    XCTAssertEqual("Hot Coffee Edit", app.staticTexts["coffeeNameText"].label)
  }

  // call after running each test
  override func tearDown() {
    Task {
      guard
        let url = URL(
          string: "https://island-bramble.glitch.me/test/clear-orders")
      else { return }

      let (_, _) = try! await URLSession.shared.data(from: url)
    }
  }

  // call before running each test
  override func setUp() {

    app = XCUIApplication()
    continueAfterFailure = false
    app.launchEnvironment = ["ENV": "TEST"]
    app.launch()

    // go to place order screen
    app.buttons["addNewOrderButton"].tap()
    // fill out the textfields
    let nameTextField = app.textFields["name"]
    let coffeeNameTextField = app.textFields["coffeeName"]
    let priceTextField = app.textFields["price"]
    let placeOrderButton = app.buttons["orderButton"]

    nameTextField.tap()
    nameTextField.typeText("John")

    coffeeNameTextField.tap()
    coffeeNameTextField.typeText("Hot Coffee")

    priceTextField.tap()
    priceTextField.typeText("4.50")

    // place the order
    let exists = NSPredicate(format: "exists == true")
    print("\(exists)")
    expectation(for: exists, evaluatedWith: placeOrderButton, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)

    XCTAssertTrue(placeOrderButton.isHittable, "Place Order button is not hittable")
    placeOrderButton.tap()

  }
}

final class when_deleting_an_order: XCTestCase {
  private var app: XCUIApplication!

  override func setUp() {
    app = XCUIApplication()
    continueAfterFailure = false
    app.launchEnvironment = ["ENV": "TEST"]
    print("ENV is TEST")
    app.launch()

    // go to place order screen
    app.buttons["addNewOrderButton"].tap()
    // fill out the textfields
    let nameTextField = app.textFields["name"]
    let coffeeNameTextField = app.textFields["coffeeName"]
    let priceTextField = app.textFields["price"]
    let placeOrderButton = app.buttons["orderButton"]

    nameTextField.tap()
    nameTextField.typeText("John")

    coffeeNameTextField.tap()
    coffeeNameTextField.typeText("Hot Coffee")

    priceTextField.tap()
    priceTextField.typeText("4.50")
    // place the order
    placeOrderButton.tap()
    print("Place Order button clicked")
  }

  func test_should_delete_order_successfully() {
    let collectionViewsQuery = XCUIApplication().collectionViews
    let cellQuery = collectionViewsQuery.cells
    let element = cellQuery.children(matching: .other).element(boundBy: 1).children(
      matching: .other
    ).element
    element.swipeLeft()
    collectionViewsQuery.buttons["Delete"].tap()
    let orderList = app.collectionViews["orderList"]
    print("Order List :\(orderList.cells.count)")
    XCTAssertEqual(0, orderList.cells.count)
  }

  func test_should_delete_all_order_successfully() {
    let collectionViewsQuery = XCUIApplication().collectionViews
    let cellQuery = collectionViewsQuery.cells
    while cellQuery.count > 0 {
      let element = cellQuery.children(matching: .other).element(boundBy: 1).children(
        matching: .other
      ).element
      element.swipeLeft()
      collectionViewsQuery.buttons["Delete"].tap()
    }
    let orderList = app.collectionViews["orderList"]
    XCTAssertEqual(0, orderList.cells.count)

  }

  override func tearDown() {
    Task {
      guard
        let url = URL(
          string: "/test/clear/orders", relativeTo: URL(string: "https://island-bramble.glitch.me")!
        )
      else { return }
      let (_, _) = try! await URLSession.shared.data(from: url)
    }
  }

}

final class when_adding_a_new_coffee_order: XCTestCase {
  private var app: XCUIApplication!

  // call before running each test
  override func setUp() {
    app = XCUIApplication()
    continueAfterFailure = false
    app.launchEnvironment = ["ENV": "TEST"]
    app.launch()

    // go to place order screen
    app.buttons["addNewOrderButton"].tap()
    // fill out the textfields
    let nameTextField = app.textFields["name"]
    let coffeeNameTextField = app.textFields["coffeeName"]
    let priceTextField = app.textFields["price"]
    let placeOrderButton = app.buttons["orderButton"]

    nameTextField.tap()
    nameTextField.typeText("Hakan")

    coffeeNameTextField.tap()
    coffeeNameTextField.typeText("Hot Coffee")

    priceTextField.tap()
    priceTextField.typeText("9.50")

    // place the order
    let exists = NSPredicate(format: "exists == true")
    print("\(exists)")
    expectation(for: exists, evaluatedWith: placeOrderButton, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)

    XCTAssertTrue(placeOrderButton.isHittable, "Place Order button is not hittable")
    placeOrderButton.tap()

  }

  func test_should_display_coffee_order_in_list_successfully() throws {

    XCTAssertEqual("Hakan", app.staticTexts["orderNameText"].label)
    XCTAssertEqual("Hot Coffee (medium)", app.staticTexts["coffeeNameAndSizeText"].label)
    XCTAssertEqual("₺9,50", app.staticTexts["coffeePriceText"].label)
  }
  // call after running each test
  override func tearDown() {
    Task {
      guard
        let url = URL(
          string: "https://island-bramble.glitch.me/test/clear-orders")
      else { return }
      let (_, _) = try! await URLSession.shared.data(from: url)
    }
  }

}

final class CoffeAppE2ETests: XCTestCase {

  func test_should_make_sure_no_orders_message_is_displayed() {
    let app = XCUIApplication()
    continueAfterFailure = false
    app.launchEnvironment = ["ENV": "TEST"]
    app.launch()
    XCTAssertEqual("No orders available!", app.staticTexts["noOrdersText"].label)
  }
}
