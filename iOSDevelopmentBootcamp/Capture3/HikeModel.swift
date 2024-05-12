//
//  HikeModel.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 6.05.2024.
//

import Foundation


struct HikeModel: Identifiable, Hashable {
    var id = UUID()    
    let name: String
    let photo: String
    let miles: Double
}
