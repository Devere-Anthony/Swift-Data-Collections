//
//  RoomType.swift
//  Hotel Manzana
//
//  Created by Devere Weaver on 1/3/24.
//

import Foundation

struct RoomType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    static func ==(lhs: RoomType, rhs: RoomType) -> Bool {
        /* Define equality for RoomType. */
        return lhs.id == rhs.id
    }
}
