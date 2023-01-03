//
//  Document.swift
//  Shape Builder ver.2
//
//  Created by Maksimilian Shelekhov on 2023/01/03.
//

import SwiftUI

enum entityRender {
    case regular, clipped, united, cutout
}
enum entityType {
    case canvas, rectangle, ellipse, triangle, text, image
}

struct Entity: Identifiable {
    let id = UUID()
    
    var title: String?
    var icon: String?
    var type: entityType
    var render: entityRender = .regular
    
    //activity
    var active: Bool = false
    var subactive: Bool = false
    
    var entities: [Entity] = []
    var devices: [Device] = []
    
    //properties
    var x: Double
    var y: Double
    var width: Double
    var height: Double
    var zindex: Double?
    var color: Color
    var opacity: Double = 1
    
    //computed properties, it took me almost 3 days to figure out these four
    var mx: Double {
        var xo: Double = 0
        for checkentity in entities {
            if checkentity.render != .clipped {
                let edge = checkentity.x + checkentity.mx
                xo = edge < xo ? edge : xo
            }
        }
        return xo
    }
    var my: Double {
        var yo: Double = 0
        for checkentity in entities {
            
            if checkentity.render != .clipped {
                let edge = checkentity.y + checkentity.my
                yo = edge < yo ? edge : yo
            }
        }
        return yo
    }
    var mwidth: Double {
        var wo: Double = width
        for checkentity in entities {
            if checkentity.render != .clipped {
                let edge = checkentity.x + checkentity.mwidth
                if edge > wo {
                    wo = edge + checkentity.mx
                }
            }
        }
        return wo - mx
    }
    var mheight: Double {
        var ho: Double = height
        for checkentity in entities {
            if checkentity.render != .clipped {
                let edge = checkentity.y + checkentity.mheight
                if edge > ho {
                    ho = edge + checkentity.my
                }
            }
        }
        return ho - my
    }
    
    //entity management
    mutating func addEntity (entity: Entity) {
        entities.append(entity)
    }
    mutating func removeEntity (entity: Entity) {
        let i: Int? = entities.firstIndex(where: { $0.id == entity.id })
        if let index: Int = i {
            entities[index].active = false
            entities.remove(at: index)
        }
    }
    mutating func moveEntity (entity: Entity, toEntityAt i: Int) {
        resetSelection()
        
        //copy to new parent
        var newentity = entity
        newentity.x = entity.x - entities[i].x
        newentity.y = entity.y - entities[i].y
        entities[i].addEntity(entity: newentity)
        
        //remove original
        removeEntity(entity: entity)
    }
    
    //entity intersect detection
    mutating func getEntityIntersecting(with item: Entity) -> Int? {
        var largestIntersectiontArea: CGFloat = 0.0
        var indexOflargestIntersectiontArea: Int?
        
        // check for all itersections ecept selcted entity itself
        let itemFrame: CGRect = CGRect(origin: CGPoint(x: item.x+item.mx, y: item.y+item.my), size: CGSize(width: item.mwidth, height: item.mheight))
        
        //        if entities.count > 0 {
        for i in 0...entities.count-1 {
            
            //subactivity
            entities[i].subactive = true
            
            if entities[i].id != item.id {
                let parentFrame: CGRect = CGRect(origin: CGPoint(x: entities[i].x+entities[i].mx, y: entities[i].y+entities[i].my), size: CGSize(width: entities[i].mwidth, height: entities[i].mheight))
                entities[i].active = false
                if parentFrame.intersects(itemFrame) {
                    
                    // if area is larger than others
                    let interSectionArea = parentFrame.intersection(itemFrame).width * parentFrame.intersection(itemFrame).height
                    if interSectionArea > largestIntersectiontArea {
                        largestIntersectiontArea = interSectionArea
                        indexOflargestIntersectiontArea = i
                    }
                }
            }
        }
        if indexOflargestIntersectiontArea != nil {
            entities[indexOflargestIntersectiontArea!].subactive = false
            entities[indexOflargestIntersectiontArea!].active = true
        }
        return indexOflargestIntersectiontArea ?? nil
    }
    
    //device management
    mutating func addDevice (device: Device) {
        devices.append(device)
    }
    
    //selection
    mutating func resetSelection() {
        for i in 0...entities.count-1 {
            
            //subactivity
            entities[i].active = false
            entities[i].subactive = false
        }
    }
    
}
