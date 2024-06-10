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

  //@StateObject private var storeModel = StoreModel(webService: FakeServices())
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

//struct iOSDevelopmentBootcampApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
//
////    @StateObject private var appState = AppState()
//    @State private var appState = AppState()
//
//    var body: some Scene {
//        WindowGroup {
//            BindingProperty()
////                .environmentObject(appState)
//                .environment(appState)
//        }
//        //.modelContainer(sharedModelContainer)
//    }
//}
