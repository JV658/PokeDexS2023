//
//  PokeData.swift
//  PokeDex
//
//  Created by Cambrian on 2023-05-29.
//

import Foundation

class PokeData: Codable {
    var name: String
    var id: Int
    var weight: Int
    var height: Int
    var is_default: Bool
    var sprites: Sprite
}

struct Sprite: Codable {
    var front_default: String
    var back_default: String
}
