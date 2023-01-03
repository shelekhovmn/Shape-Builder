//
//  DeviceView.swift
//  Shape Builder ver.2
//
//  Created by Maksimilian Shelekhov on 2023/01/03.
//

import SwiftUI

struct DeviceView: View {
    
    @Binding var screen: Entity
    @Binding var device: Device
    
    var body: some View {
        VStack{
            Text(device.title)
            ZStack { // canvas
                ForEach($screen.entities) { entity in
                    EntityView(entity: entity, parent: $screen)
                }
            }
            .frame(minWidth: nil, maxWidth: .infinity, minHeight: nil, maxHeight: .infinity, alignment: .topLeading)
            .frame(width: device.dimensions.width, height: device.dimensions.height)
            .background(screen.color)
            .clipShape(Rectangle())
        }
    }
}
