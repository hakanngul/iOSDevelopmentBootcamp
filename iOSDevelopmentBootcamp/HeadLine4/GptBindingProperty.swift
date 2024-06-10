//
//  GptBindingProperty.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 12.05.2024.
//

import SwiftUI



// AppState sınıfı, uygulama genelinde kullanılacak durumu yönetir.
class AppStateX: ObservableObject {
  @Published var isOn: Bool = false
}

// LightBulbView, ışık durumunu görselleştiren ve değiştiren bir view'dir.
struct LightBulbViewX: View {
  @EnvironmentObject private var appState: AppStateX

  var body: some View {
    VStack {
      Image(systemName: appState.isOn ? "lightbulb.fill" : "lightbulb")
        .resizable()
        .frame(width: 100, height: 150)
        .foregroundStyle(appState.isOn ? .yellow : .gray)
        .padding()
      Button("Toggle") {
        appState.isOn.toggle()
      }
    }
  }
}

// LightRoomView, LightBulbView'ı içeren bir konteyner view'dir.
struct LightRoomViewX: View {
  var body: some View {
    LightBulbViewX()
  }
}

// BindingProperty, uygulamanın ana view'ını temsil eder.
struct GptBindingProperty: View {
  @EnvironmentObject private var appState: AppStateX

  var body: some View {
    VStack {
      LightRoomViewX()
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(appState.isOn ? .black : .white)
  }
}


// Uygulamanın önizlemesi için SwiftUI PreviewProvider.

#Preview{
    GptBindingProperty().environmentObject(AppStateX())
}
