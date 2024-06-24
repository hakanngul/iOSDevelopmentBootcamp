//
//  iOSDevelopmentBootcampApp.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 5.05.2024.
//

import SwiftUI

//import SwiftData

@main
struct iOSDevelopmentBootcampApp: App {

  @StateObject private var model: CoffeModel

  init() {
    var config = Configuration()
    let webService = WebServiceCoffeOrder(baseURL: config.environment.baseUrl)
    _model = StateObject(wrappedValue: CoffeModel(webService: webService))
  }

  var body: some Scene {
    WindowGroup {
      HelloCoffeApp().environmentObject(model)
    }
  }
}
