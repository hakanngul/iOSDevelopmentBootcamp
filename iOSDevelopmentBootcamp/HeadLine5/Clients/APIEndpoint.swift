//
//  APIEndpoint.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 24.05.2024.
//

import Foundation

enum APIEndpoint {
    static let baseUrl = "https://api.openweathermap.org"

    case cordinatesByLocationName(String)
    case weatherByLatLon(Double, Double)

    private var path: String {
        switch self {
        case .cordinatesByLocationName(let city):
            return "/geo/1.0/direct?q=\(city)&appid=\(Constants.Keys.weatherApiKey)"
        case .weatherByLatLon(let lat, let lon):
            return "/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Constants.Keys.weatherApiKey)"
        }
    }

    static func endPointURL(for endpoint: APIEndpoint) -> URL {
        let endpointPath = endpoint.path
        return URL(string: baseUrl + endpointPath)!
    }
}
