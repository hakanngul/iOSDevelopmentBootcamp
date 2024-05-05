//
//  Item.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 5.05.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
