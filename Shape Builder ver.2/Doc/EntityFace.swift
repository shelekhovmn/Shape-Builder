//
//  EntityFace.swift
//  Shape Builder ver.2
//
//  Created by Maksimilian Shelekhov on 2023/01/03.
//

import SwiftUI

struct EntityFace: View {
    var entity: Entity
    
    @ViewBuilder var body: some View {
        if entity.type == .rectangle {
            RectangleView(tl: 1, tr: 1, br: 1, bl: 1)
        }
//        if entity.type == .ellipse{
//            EllipseView(tl: 1, tr: 1, br: 1, bl: 1)
//        }
    }
}

struct RectangleView: Shape {
    var tl: Double
    var tr: Double
    var br: Double
    var bl: Double
    
    func path(in rect: CGRect) -> Path {
        Path {
            
            //right top
            $0.move(to: CGPoint(x: rect.minX+tl, y: rect.minY))
            $0.addLine(to: CGPoint(x: rect.maxX-tr, y: rect.minY))
            $0.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY+tr), control: CGPoint(x: rect.maxX, y: rect.minY))
            
            //right bottom
            $0.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY-br))
            $0.addQuadCurve(to: CGPoint(x: rect.maxX-br, y: rect.maxY), control: CGPoint(x: rect.maxX, y: rect.maxY))
            
            //left bottom
            $0.addLine(to: CGPoint(x: rect.minX+bl, y: rect.maxY))
            $0.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY-bl), control: CGPoint(x: rect.minX, y: rect.maxY))
            
            // left top
            $0.addLine(to: CGPoint(x: rect.minX, y: rect.minY+tl))
            $0.addQuadCurve(to: CGPoint(x: rect.minX+tl, y: rect.minY), control: CGPoint(x: rect.minX, y: rect.minY))
            
            $0.closeSubpath()
        }
    }
}

//struct EllipseView: Shape {
//    var tl: Double
//    var tr: Double
//    var br: Double
//    var bl: Double
//
//    func path(in rect: CGRect) -> Path {
//        Path {
//
//            //right top
//            $0.move(to: CGPoint(x: rect.minX+tl, y: rect.minY))
//            $0.addLine(to: CGPoint(x: rect.maxX-tr, y: rect.minY))
//            $0.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY+tr), control: CGPoint(x: rect.maxX, y: rect.minY))
//
//            //right bottom
//            $0.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY-br))
//            $0.addQuadCurve(to: CGPoint(x: rect.maxX-br, y: rect.maxY), control: CGPoint(x: rect.maxX, y: rect.maxY))
//
//            //left bottom
//            $0.addLine(to: CGPoint(x: rect.minX+bl, y: rect.maxY))
//            $0.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY-bl), control: CGPoint(x: rect.minX, y: rect.maxY))
//
//            // left top
//            $0.addLine(to: CGPoint(x: rect.minX, y: rect.minY+tl))
//            $0.addQuadCurve(to: CGPoint(x: rect.minX+tl, y: rect.minY), control: CGPoint(x: rect.minX, y: rect.minY))
//
//            $0.closeSubpath()
//        }
//    }
//}
