//
//  HelloSwiftUi.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 5.05.2024.
//

import SwiftUI

struct HelloSwiftUi: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }.padding()
    }
}

#Preview {
    HelloSwiftUi()
}
