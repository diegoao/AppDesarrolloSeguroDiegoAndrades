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
class Sprites: Codable {
    let front_default: String
}

