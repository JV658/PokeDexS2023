//
//  Pokedex.swift
//  PokeDex
//
//  Created by Cambrian on 2023-05-29.
//

import Foundation

struct Pokedex: Codable {
    var results: [Pokemon]
}

struct Pokemon: Codable {
    var name: String
    var url: String
}
