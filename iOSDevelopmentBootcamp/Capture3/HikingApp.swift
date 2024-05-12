//
//  HikingApp.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 6.05.2024.
//

import SwiftUI

struct HikingApp: View {
  let hikes = [
    HikeModel(name: "Salmon berry Trail", photo: "sal", miles: 6),
    HikeModel(name: "Tom, Dick, and Harry Mountain", photo: "tom", miles: 5.8),
    HikeModel(name: "Tamanawas Falls", photo: "tam", miles: 5),
  ]
  /// Viewbody
  var body: some View {
    NavigationStack {
      List(hikes) { hike in
        NavigationLink(value: hike) {
          HikeCellView(hike: hike)
        }
      }.navigationTitle("Hikes")
        .navigationDestination(for: HikeModel.self) { hike in
            HikeDetailView(hike: hike)
        }
    }
  }
}

#Preview{
  HikingApp()
}

struct HikeCellView: View {
  let hike: HikeModel
  var body: some View {
    HStack(alignment: .top) {
      Image(hike.photo)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .frame(width: 100)  //, height: 100)
      VStack(alignment: .leading) {
        Text(hike.name)
        Text("\(hike.miles.formatted()) miles")
          .foregroundStyle(.red)
      }
    }
  }
}
