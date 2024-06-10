//
//  WeatherApp.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 24.05.2024.
//

import SwiftData
import SwiftUI

struct WeatherApp: View {
  @State private var city: String = ""
  @State private var isFetchingWeather = false
  let geocodingClient = GeocondingClient()
  let weatherClient = WeatherClient()
  @State private var weather: Weather?

  private func fetchWeather() async {
    do {
      guard let location = try await geocodingClient.coordinateByCity(city) else { return }
      weather = try await weatherClient.fetchWeather(location: location)
    } catch {
      print(error)
    }
  }

  var body: some View {
    VStack {
      TextField("City", text: $city)
        .textFieldStyle(.roundedBorder)
        .onSubmit {
          isFetchingWeather = true
        }
        .task(id: isFetchingWeather) {
          if isFetchingWeather {
            await fetchWeather()
            isFetchingWeather = false
            city = ""
          }
        }
      Spacer()
      if let weather {
          Text("\(MeasurementFormatter.temperature(value: weather.temp))")
              .font(.system(size: 100))
      }
      Spacer()
    }
    .padding()
  }
}

#Preview{
  WeatherApp()
}
