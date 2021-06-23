//
//  DataModel.swift
//  ML_Algorithms
//
//  Created by Eduardo Oliveira on 17/06/21.
//

import Foundation
import SwiftUI

enum GroupType {
    case red
    case blue
    case green
}

class GroupCounter {
    var count: Int
    var group: GroupType
    
    init(count: Int, group: GroupType) {
        self.count = count
        self.group = group
    }
    
    func plusCounter() {
        self.count += 1
    }
}

struct MapPointWithDistance: Hashable {
    var mapPoint: MapPoint
    var distance: CGFloat
}

struct MapPoint: Hashable {
    var xPos: Int
    var yPos: Int
    var color: Color
    var group: GroupType?
    
    init(xPos: Int, yPos: Int, group: GroupType) {
        self.xPos = xPos
        self.yPos = yPos
        self.group = group
        switch group {
        case .red:
            self.color = .red
        case .blue:
            self.color = .blue
        case .green:
            self.color = .green
        }
    }
}

extension MapPoint {
    static let points: [MapPoint] = [
        MapPoint(xPos: 31, yPos: 53, group: .red),
        MapPoint(xPos: 32, yPos: 53, group: .red),
        MapPoint(xPos: 35, yPos: 60, group: .red),
        MapPoint(xPos: 45, yPos: 53, group: .red),
        MapPoint(xPos: 45, yPos: 70, group: .red),
        MapPoint(xPos: 48, yPos: 55, group: .red),
        MapPoint(xPos: 31, yPos: 62, group: .red),
        MapPoint(xPos: 33, yPos: 54, group: .red),
        MapPoint(xPos: 47, yPos: 65, group: .red),
        MapPoint(xPos: 50, yPos: 70, group: .red),
        MapPoint(xPos: 11, yPos: 43, group: .red),
        MapPoint(xPos: 12, yPos: 43, group: .red),
        MapPoint(xPos: 5, yPos: 40, group: .red),
        MapPoint(xPos: 25, yPos: 43, group: .red),
        MapPoint(xPos: 5, yPos: 70, group: .red),
        MapPoint(xPos: 48, yPos: 25, group: .red),
        MapPoint(xPos: 11, yPos: 32, group: .red),
        MapPoint(xPos: 3, yPos: 54, group: .red),
        MapPoint(xPos: 11, yPos: 24, group: .red),
        MapPoint(xPos: 10, yPos: 30, group: .red),
        MapPoint(xPos: 55, yPos: 85, group: .red),
        MapPoint(xPos: 15, yPos: 95, group: .red),
        MapPoint(xPos: 35, yPos: 80, group: .red),
        MapPoint(xPos: 5, yPos: 88, group: .red),
        MapPoint(xPos: 5, yPos: 5, group: .red),
        MapPoint(xPos: 25, yPos: 75, group: .red),
        MapPoint(xPos: 35, yPos: 35, group: .red),
        MapPoint(xPos: 12, yPos: 10, group: .red),
        MapPoint(xPos: 54, yPos: 45, group: .red),
        MapPoint(xPos: 65, yPos: 65, group: .red),
        MapPoint(xPos: 42, yPos: 3, group: .red),
        MapPoint(xPos: 54, yPos: 42, group: .red),
        MapPoint(xPos: 5, yPos: 55, group: .red),
        
        MapPoint(xPos: 90, yPos: 53, group: .blue),
        MapPoint(xPos: 121, yPos: 53, group: .blue),
        MapPoint(xPos: 119, yPos: 60, group: .blue),
        MapPoint(xPos: 105, yPos: 63, group: .blue),
        MapPoint(xPos: 100, yPos: 70, group: .blue),
        MapPoint(xPos: 128, yPos: 55, group: .blue),
        MapPoint(xPos: 130, yPos: 62, group: .blue),
        MapPoint(xPos: 108, yPos: 54, group: .blue),
        MapPoint(xPos: 122, yPos: 65, group: .blue),
        MapPoint(xPos: 118, yPos: 70, group: .blue),
        MapPoint(xPos: 130, yPos: 53, group: .blue),
        MapPoint(xPos: 81, yPos: 73, group: .blue),
        MapPoint(xPos: 89, yPos: 40, group: .blue),
        MapPoint(xPos: 85, yPos: 53, group: .blue),
        MapPoint(xPos: 100, yPos: 41, group: .blue),
        MapPoint(xPos: 128, yPos: 23, group: .blue),
        MapPoint(xPos: 100, yPos: 76, group: .blue),
        MapPoint(xPos: 138, yPos: 24, group: .blue),
        MapPoint(xPos: 102, yPos: 25, group: .blue),
        MapPoint(xPos: 128, yPos: 30, group: .blue),
        MapPoint(xPos: 125, yPos: 65, group: .blue),
        MapPoint(xPos: 85, yPos: 65, group: .blue),
        MapPoint(xPos: 115, yPos: 70, group: .blue),
        MapPoint(xPos: 75, yPos: 68, group: .blue),
        MapPoint(xPos: 75, yPos: 15, group: .blue),
        MapPoint(xPos: 95, yPos: 45, group: .blue),
        MapPoint(xPos: 105, yPos: 45, group: .blue),
        MapPoint(xPos: 82, yPos: 20, group: .blue),
        MapPoint(xPos: 124, yPos: 45, group: .blue),
        MapPoint(xPos: 135, yPos: 65, group: .blue),
        MapPoint(xPos: 72, yPos: 10, group: .blue),
        MapPoint(xPos: 114, yPos: 35, group: .blue),
        MapPoint(xPos: 125, yPos: 85, group: .blue),
        
        MapPoint(xPos: 55, yPos: 140, group: .green),
        MapPoint(xPos: 50, yPos: 139, group: .green),
        MapPoint(xPos: 59, yPos: 130, group: .green),
        MapPoint(xPos: 45, yPos: 133, group: .green),
        MapPoint(xPos: 60, yPos: 130, group: .green),
        MapPoint(xPos: 48, yPos: 135, group: .green),
        MapPoint(xPos: 50, yPos: 132, group: .green),
        MapPoint(xPos: 65, yPos: 124, group: .green),
        MapPoint(xPos: 52, yPos: 145, group: .green),
        MapPoint(xPos: 48, yPos: 140, group: .green),
        MapPoint(xPos: 105, yPos: 140, group: .green),
        MapPoint(xPos: 90, yPos: 99, group: .green),
        MapPoint(xPos: 89, yPos: 100, group: .green),
        MapPoint(xPos: 75, yPos: 133, group: .green),
        MapPoint(xPos: 80, yPos: 110, group: .green),
        MapPoint(xPos: 98, yPos: 125, group: .green),
        MapPoint(xPos: 20, yPos: 132, group: .green),
        MapPoint(xPos: 35, yPos: 124, group: .green),
        MapPoint(xPos: 72, yPos: 145, group: .green),
        MapPoint(xPos: 108, yPos: 140, group: .green),
        MapPoint(xPos: 140, yPos: 125, group: .green),
        MapPoint(xPos: 135, yPos: 140, group: .green),
        MapPoint(xPos: 132, yPos: 120, group: .green),
        MapPoint(xPos: 10, yPos: 130, group: .green),
        MapPoint(xPos: 20, yPos: 125, group: .green),
        MapPoint(xPos: 25, yPos: 105, group: .green),
        MapPoint(xPos: 130, yPos: 135, group: .green),
        MapPoint(xPos: 90, yPos: 120, group: .green),
        MapPoint(xPos: 109, yPos: 94, group: .green),
        MapPoint(xPos: 140, yPos: 90, group: .green),
        MapPoint(xPos: 100, yPos: 120, group: .green),
        MapPoint(xPos: 130, yPos: 120, group: .green),
        MapPoint(xPos: 140, yPos: 110, group: .green),
        MapPoint(xPos: 130, yPos: 100, group: .green),
    ]
    
    
}
