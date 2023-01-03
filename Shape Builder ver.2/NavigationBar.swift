//
//  NavigationBar.swift
//  Shape Builder ver.2
//
//  Created by Maksimilian Shelekhov on 2023/01/03.
//

import SwiftUI

struct NavigationBar: View {
    
    @Binding var document: Document
    
    var body: some View {
        VStack (alignment: .leading) {
            
            VStack { //title
                Text(document.title)
                    .fontWeight(.semibold)
                    .font(.title2)
                    .padding(.horizontal)
            }
            
            VStack { // screens
                List {
                    ForEach($document.screens) { screen in
                        NavigationLink {
                            ScreenView(screen: screen)
                        } label: {
                            Label(screen.wrappedValue.title ?? "no title", systemImage: screen.wrappedValue.icon ?? "questionmark")
                        }
                    }
                }.listStyle(SidebarListStyle())
            }
        }.toolbar {
            Spacer()
        }
    }
}
