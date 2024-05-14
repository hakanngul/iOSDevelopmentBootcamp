//
//  BindingProperty.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 12.05.2024.
//

// after ios 17
import Observation
import SwiftUI

// Pre ios 17
//class AppState: ObservableObject {
//  @Published var isOn: Bool = false  // when i change to this then subs get the value
//}

@Observable
class AppState {
  //  @Published var isOn: Bool = false  // when i change to this then subs get the value
  var isOn: Bool = false
}

struct LightBulbView: View {
  //  @Binding var isOn: Bool
  //  @EnvironmentObject private var appState: AppState
  @Environment(AppState.self) private var appState: AppState
  var body: some View {
      @Bindable var appState = appState
    VStack {
      Image(systemName: appState.isOn ? "lightbulb.fill" : "lightbulb")

        .resizable()
        .frame(width: 100, height: 150)
        .foregroundStyle(appState.isOn ? .yellow : .gray)
        .padding()
      //      Button("Toogle") {
      //        appState.isOn.toggle()
      //      }
            Toggle("IsOn", isOn: $appState.isOn)
            .font(.largeTitle)
            .foregroundStyle(appState.isOn ? .yellow : .gray)
    }
  }
}

struct LightRoomView: View {
  //  @Binding var isOn: Bool
  var body: some View {
    //    LightBulbView(isOn: $isOn)
    LightBulbView()
  }
}

struct BindingProperty: View {
  //  @EnvironmentObject private var appState: AppState
  @Environment(AppState.self) private var appState: AppState

  @State private var isLightOn: Bool = false
  var body: some View {
    VStack {
      //      LightRoomView(isOn: $isLightOn)
      LightRoomView()
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(appState.isOn ? .black : .white)
  }
}

#Preview{
  BindingProperty()
    //        .environmentObject(AppState())
    .environment(AppState())
}
