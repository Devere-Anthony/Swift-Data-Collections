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
    static var all:[RoomType] {
        return [RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
                RoomType(id: 1, name: "One King", shortName: "K", price: 209),
                RoomType(id: 2, name: "Penthouse Suit", shortName: "PHS", price: 309)
                ]
    }
    
    static func ==(lhs: RoomType, rhs: RoomType) -> Bool {
        /* Define equality for RoomType. */
        return lhs.id == rhs.id
    }
}
