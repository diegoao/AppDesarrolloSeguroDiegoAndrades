//
//  PokemonInfoModel.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 20/5/24.
//

import Foundation

// MARK: - PokemonInfoModel
struct PokemonInfoModel: Codable {
    
    let species: Species
    let sprites: Sprites

}

// MARK: - Species
struct Species: Codable {
    let name: String
    let url: String
}

// MARK: - Sprites
struct Sprites: Codable {
    let front_default: String
    let other: Other?
}

// MARK: - Other
struct Other: Codable {
    let dreamWorld: DreamWorld
    let home: Home
    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case home
    }
}

// MARK: - DreamWorld
struct DreamWorld: Codable {
    let frontDefault: String
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - Home
struct Home: Codable {
    let frontDefault: String
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
