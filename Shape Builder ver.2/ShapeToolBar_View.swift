//
//  ShapeToolBar_View.swift
//  Shape Builder ver.2
//
//  Created by Maksimilian Shelekhov on 2023/01/03.
//

import SwiftUI
import Photos

struct ShapeToolBar_View: View {
    
//    @EnvironmentObject var appStore = []
//    @State var assetList:[PHAsset] = []
    @State var showIconPicker = false
    
    @Binding var screen: Entity
    
    
    var body: some View {
        
        
        HStack{
            VStack{
                HStack(spacing:20){
                    Button(action: {
                        screen.addEntity(entity: randomItem)
                    }, label: {
                        Text("Rectangle")
                        Image(systemName: "rectangle")
                    })
                    
                    Button(action: {
                        screen.addEntity(entity: randomItem1)
                    }, label: {
                        Text("Circle")
                        Image(systemName: "circle")
                    })
                   
                    Button(action: {
                        //Open SF Symbols
                    }, label: {
                        Text("Icon")
                        Image(systemName: "star")
                    })
                    
                    Button(action: {
                        //Add text
                    }, label: {
                        Text("Text")
                        Image(systemName: "textbox")
                    })
                    
                    Button(action: {
                        //Open photo
                    }, label: {
                        Text("Photo")
                        Image(systemName: "photo")
                    })
                }
                .accentColor(.white)
            }
        }
    }
}

var colors: [Color] = [.yellow, .green, .orange, .blue, .purple]
var randomItem: Entity { Entity(type: .rectangle,
                                x: 30, y: 30,
                                width: Double.random(in: 50...100),
                                height: Double.random(in: 50...100),
                                color: colors.randomElement()!)}


var colors1: [Color] = [.yellow, .green, .orange, .blue, .purple]
var randomItem1: Entity { Entity(type: .ellipse,
                                x: 30, y: 30,
                                width: Double.random(in: 50...100),
                                height: Double.random(in: 50...100),
                                color: colors1.randomElement()!)}
