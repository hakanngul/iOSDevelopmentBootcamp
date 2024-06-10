//
//  OrderCellView.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 10.06.2024.
//

import SwiftUI

struct OrderCellView: View {
  let order: OrderModel
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(order.name).accessibilityIdentifier("orderNameText").bold()
        
        Text("\(order.coffeeName) (\(order.size.rawValue))")
          .accessibilityIdentifier("coffeeNameAndSizeText").opacity(0.5)
      }
      
      Spacer()
      Text(order.total as NSNumber, formatter: NumberFormatter.currency)
        .accessibilityIdentifier("coffeePriceText")
    }
  }
}

//#Preview {
//    OrderCellView()
//}
