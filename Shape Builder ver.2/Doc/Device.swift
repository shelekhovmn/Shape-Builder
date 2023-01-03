//
//  Device.swift
//  Shape Builder ver.2
//
//  Created by Maksimilian Shelekhov on 2023/01/03.
//

import SwiftUI

enum deviceType: String {
    case iPhone13Mini = "iPhone 13 Mini"
    case iPhone13 = "iPhone 13"
    case iPhone13ProMax = "iPhone 13 Pro Max"
    case iconLarge = "Large Icon"
}

struct Device: Identifiable {
    let id = UUID()
    let type: entityType = .canvas
    
    var title: String
    var dimensions: CGSize
    
    init(_ type: deviceType) {
        self.title = type.rawValue
        self.dimensions = .zero
        
        
        //Screens(iPhones)
        
        if type == .iPhone13Mini {
            dimensions = CGSize(width: 375, height: 812)
        }
        if type == .iPhone13 {
            dimensions = CGSize(width: 390, height: 844)
        }
        if type == .iPhone13ProMax {
            dimensions = CGSize(width: 428, height: 926)
        }
        //
        if type == .iconLarge {
            dimensions = CGSize(width: 256, height: 256)
        }
        
    }
}
