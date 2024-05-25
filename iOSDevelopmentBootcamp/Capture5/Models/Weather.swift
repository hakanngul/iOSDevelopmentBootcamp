//
//  WeatherModel.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 24.05.2024.
//

import Foundation
import SwiftData

struct WeatherResponse: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
//    let feels_like: String
}
