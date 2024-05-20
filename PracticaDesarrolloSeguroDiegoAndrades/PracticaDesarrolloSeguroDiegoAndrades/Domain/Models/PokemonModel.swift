//
//  pokemon.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 19/5/24.
//

import Foundation

// MARK: - PokemonList
struct PokemonModel: Decodable {
    let results: [Result]?
}

// MARK: - Result
struct Result: Decodable {
    let name: String
    let url: String
}
