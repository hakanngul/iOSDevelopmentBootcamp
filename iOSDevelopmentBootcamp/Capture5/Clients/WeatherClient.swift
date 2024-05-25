//
//  WeatherClient.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 25.05.2024.
//

import Foundation


struct WeatherClient {
    func fetchWeather(location: Location) async throws -> Weather {
        let (data, response) = try await URLSession.shared.data(from: APIEndpoint.endPointURL(for: .weatherByLatLon(location.lat, location.lon)))
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        return try JSONDecoder().decode(WeatherResponse.self, from: data).main
    }
}
