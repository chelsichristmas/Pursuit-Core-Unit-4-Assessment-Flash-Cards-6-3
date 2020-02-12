//
//  Card.swift
//  Unit4Assessment
//
//  Created by Chelsi Christmas on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation
struct CardStruct: Codable & Equatable {
    let cards: [Card]
}
struct Card: Codable & Equatable {
    let cardTitle: String
    let facts: [String]
}
