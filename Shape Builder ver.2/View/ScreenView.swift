//
//  ScreenView.swift
//  Shape Builder ver.2
//
//  Created by Maksimilian Shelekhov on 2023/01/03.
//

import SwiftUI

struct ScreenView: View {
    
    @Binding var screen: Entity
    
    var body: some View {
        ScrollView ([.horizontal, .vertical], showsIndicators: false) {
            HStack (alignment: .top, spacing: 80) { //screen
                ForEach($screen.devices) { device in
                    DeviceView(screen: $screen, device: device)
                }
            }
        }.ignoresSafeArea()
            .toolbar{
                Menu {
                    ShapeToolBar_View(screen: $screen)
                } label: {
                    Image(systemName: "plus.square")
                }
                .menuStyle(.button)
            }
    }
}

