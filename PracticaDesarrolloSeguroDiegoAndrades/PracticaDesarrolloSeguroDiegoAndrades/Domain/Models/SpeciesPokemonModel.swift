//
//  SpeciesPokemonModel.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 21/5/24.
//

import Foundation

// MARK: - PokemonSpeciesModel
struct SpeciesPokemonModel: Codable {
    let flavorTextEntries: [FlavorTextEntry]
    
    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
}

// MARK: - FlavorTextEntry
struct FlavorTextEntry: Codable {
    let flavorText: String
    let language: LanguageColor
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
    }
}

// MARK: - LanguageColor
struct LanguageColor: Codable {
    let name: String
    let url: String
}
