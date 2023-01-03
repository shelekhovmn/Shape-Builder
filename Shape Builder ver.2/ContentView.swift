//
//  ContentView.swift
//  Shape Builder ver.2
//
//  Created by Maksimilian Shelekhov on 2023/01/03.
//

import SwiftUI

struct ContentView: View {
    
    @State var document = Document(title: "My App")
    
    
    var body: some View {
        
        NavigationView{
            VStack{
                VStack { // screens
                    NavigationBar(document: $document)
                }.listStyle(SidebarListStyle())
            }
        }.onAppear{
            var myscreena = Entity(title: "Home", icon: "house.fill", type: .canvas, x: 0, y: 0, width: 100, height: 100, color: .gray)
            myscreena.addDevice(device: Device(.iPhone13))
            myscreena.addEntity(entity: randomItem)
            myscreena.addDevice(device: Device(.iconLarge))
            
            document.addScreen(screen: myscreena)
        }
    }
}

extension View {
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> TupleView<(Self?, Content?)> {
        if conditional {
            return TupleView((nil, content(self)))
        } else {
            return TupleView((self, nil))
        }
    }
}
