//
//  ListInSwiftUi.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 12.05.2024.
//

import SwiftUI

struct ListInSwiftUi: View {
  @State private var search: String = ""
  @State private var name: String = ""
  @State private var selectedName: String = ""
  @State private var friends: [String] = [
    "John", "Jane", "Jack", "Jill", "Jenny", "Jenifer", "Johanna",
  ]
  @State private var filteredFriends: [String] = []
  var body: some View {
    VStack {
      //      TextField("Enter name", text: $name)
      //        .textFieldStyle(.roundedBorder)
      //        .onSubmit {
      //          friends.append(name)
      //          name = ""
      //        }

      List(filteredFriends, id: \.self) { friend in
        Text(friend)
          .onTapGesture {
            selectedName = friend
          }
      }
      .listStyle(.plain)
      .searchable(text: $search)
      .onChange(of: search) {
        filteredFriends = friends.filter { $0.contains(search) }
        //        if filterFriends.isEmpty {
        //          filterFriends = friends
        //        }
        if search.isEmpty {
          filteredFriends = friends
        }

      }
      Text(selectedName.count == 0 ? "List in SwiftUI" : selectedName)
        .font(.title)

    }.padding()
      .onAppear(perform: {
        filteredFriends = friends
      })
      .navigationTitle("Friends")
  }
}

#Preview{
  NavigationStack {
    ListInSwiftUi()
  }
}
