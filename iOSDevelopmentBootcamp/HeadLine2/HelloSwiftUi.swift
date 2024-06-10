//
//  HelloSwiftUi.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 5.05.2024.
//

import SwiftUI

struct HelloSwiftUi: View {
var myImage = "https://www.worldatlas.com/r/w1200/upload/d6/1f/60/shutterstock-1051182467.jpg"
  var body: some View {
    VStack {
      Image("costa-rica")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous));
        
        AsyncImage(url: URL(string: myImage)) { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        } placeholder: {
            //Text("Downloading...")
            ProgressView("Downloading...")
        }

            
      Text("First Line")
        .foregroundStyle(.cyan)
        .font(.title3)
        .padding([.top, .bottom], 20)
      Text("Second Line")
        .foregroundStyle(.green)
      Text("Third Line")
      HStack {
        Text("Left")
        Text("Right").fontWeight(.heavy)
      }
    }
    .foregroundStyle(.orange)
    .padding()
  }
}

#Preview{
  HelloSwiftUi()
}
