//
//  GeocondingClient.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 24.05.2024.
//

import Foundation

enum NetworkError: Error {
  case invalidResponse
  case decodingError
  case badUrl
  case badRequest
}

struct GeocondingClient {
  func coordinateByCity(_ city: String) async throws -> Location? {
    let (data, response) = try await URLSession.shared.data(
      from: APIEndpoint.endPointURL(
        for: .cordinatesByLocationName(
          city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city))
    )

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw NetworkError.invalidResponse
    }

    do {
      let locations = try JSONDecoder().decode([Location].self, from: data)
      return locations.first
    } catch {
      throw NetworkError.decodingError
    }
  }
}
