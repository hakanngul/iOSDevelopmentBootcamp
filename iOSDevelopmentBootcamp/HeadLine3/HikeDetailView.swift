//
//  HikeDetailView.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 12.05.2024.t
//

import SwiftUI

struct HikeDetailView: View {
  let hike: HikeModel
    @State private var zoomed: Bool = false
    
    
    
  var body: some View {
    VStack {
      Image(hike.photo)
        .resizable()
        .aspectRatio(contentMode: zoomed ? .fill: .fit)
        .onTapGesture {
            withAnimation {
                zoomed.toggle()
            }
            
        }
      Text(hike.name)
        .font(.title)
      Text("\(hike.miles.formatted()) miles")
      Spacer()
    }
    .navigationTitle(hike.name)
//    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview{
  NavigationStack {
    HikeDetailView(
      hike:
        HikeModel(name: "Salmon berry Trail", photo: "sal", miles: 6))
  }
}
