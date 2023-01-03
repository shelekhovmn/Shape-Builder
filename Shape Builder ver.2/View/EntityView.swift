//
//  EntityView.swift
//  Shape Builder ver.2
//
//  Created by Maksimilian Shelekhov on 2023/01/03.
//

import SwiftUI

struct EntityView: View {
    
    @Binding var entity: Entity
    @Binding var parent: Entity
    
    @State var active: Bool = false
    @State var offset: CGPoint = .zero
    @State var intersectingEntityIndex: Int?
    
    //events
    @State private var tapped: Bool = false
    private var onTap: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { _ in
                if !tapped {
                    tapped = true
                    offset =  CGPoint(x: entity.x, y: entity.y)
                }
            }
            .onEnded { _ in
                tapped = false
            }
    }
    private var onDrag: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { value in
                entity.x = offset.x + value.translation.width
                entity.y = offset.y + value.translation.height
                //nesting
                intersectingEntityIndex = parent.getEntityIntersecting(with: entity)
            }
            .onEnded { _ in
                parent.resetSelection()
                //nesting
                if intersectingEntityIndex != nil {
                    parent.moveEntity(entity: entity, toEntityAt: intersectingEntityIndex!)
                }
            }
    }
    
    var ActiveView: some View {
        GeometryReader{ _ in
            Rectangle().foregroundColor(.clear).border(.blue, width: 1)
                .frame(width: entity.mwidth, height: entity.mheight)
                .offset(x:entity.mx+entity.x, y:entity.my+entity.y)
        }
    }
    
    var SubactiveView: some View {
        GeometryReader{ _ in
            Rectangle().foregroundColor(.clear).border(.gray, width: 1)
                .blendMode(.difference)
                .frame(width: entity.mwidth, height: entity.mheight)
                .offset(x:entity.mx+entity.x, y:entity.my+entity.y)
        }
    }
   
    
    var body: some View {
        ZStack { // clipped
            ZStack { // body
                
                EntityFace(entity: entity) //face
                    .foregroundColor(entity.color)
                    .opacity(entity.opacity)
                    .frame(width: entity.width, height: entity.height)
                    .highPriorityGesture(active ? nil : onTap)
                    .simultaneousGesture(active ? nil : onDrag)
                
//                ZStack { //entities
                    ForEach($entity.entities) { entity in
                        EntityView(entity: entity, parent: $entity)
                    }
//                }
                
            }//body
            .frame(width: entity.width, height: entity.height)
            .offset(x: entity.width/2, y: entity.height/2)
            .position(x: entity.x, y: entity.y)
            
        }//@clipped
        .if(entity.render == .clipped && parent.type != .canvas) {$0.clipShape(RectangleView(tl: 1, tr: 1, br: 1, bl: 1))}
        .frame(maxWidth: parent.type == .canvas ? .infinity : parent.width, maxHeight: parent.type == .canvas ? .infinity : parent.height)
        .overlay(entity.subactive ? SubactiveView : nil)
        .overlay(entity.active ? ActiveView : nil)
        
        //
        .contextMenu {
            
            Button { //wrap
                entity.render = entity.render == .clipped ? .regular : .clipped
            } label: {Text(entity.render == .clipped ? "Unwrap" : "Wrap")}
            
            Divider()
            
            Button{ //delete
                parent.removeEntity(entity: entity)
            } label: {Text("Delete").foregroundColor(.red)}
        }
    }
}

