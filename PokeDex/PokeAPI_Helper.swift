//
//  PokeAPI_Helper.swift
//  PokeDex
//
//  Created by Cambrian on 2023-05-29.
//

import Foundation
import UIKit

enum PokeAPI_Errors: Error {
    case cannotConvertURL
}

class PokeAPI_Helper {
    private static var baseURLString = "https://pokeapi.co/api/v2/pokemon?limit=351"
    
    public static func fetch(urlString: String) async throws -> Data {
        guard
            let url = URL(string: urlString)
        else { throw PokeAPI_Errors.cannotConvertURL}
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return data
    }
    
    
    public static func fetchPokedex() async throws -> Pokedex{
        let data = try await fetch(urlString: baseURLString)
        
        let decoder = JSONDecoder()
        
        let pokedex = try decoder.decode(Pokedex.self, from: data)
        
        return pokedex
    }
    
    public static func fetchPokeData(urlString: String) async throws -> PokeData {
        let data = try await fetch(urlString: urlString)
        
        let decoder = JSONDecoder()
        
        let pokeData = try decoder.decode(PokeData.self, from: data)
        
        return pokeData
    }
    
    public static func fetchPokeImage(urlString: String) async throws -> UIImage? {
        let data = try await fetch(urlString: urlString)
                
        let uiImage = UIImage(data: data)
        
        return uiImage
    }
}
