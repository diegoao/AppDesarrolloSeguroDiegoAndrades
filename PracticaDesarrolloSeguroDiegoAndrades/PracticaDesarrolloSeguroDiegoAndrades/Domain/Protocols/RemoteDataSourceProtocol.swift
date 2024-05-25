//
//  RemoteDataSourceProtocol.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 19/5/24.
//

import Foundation

protocol RemoteDataSourceProtocol {
    
    // MARK: Properties
    var urlRequestHelper: URLRequestHelperProtocol { get }
    
    // MARK: Functions
    func pokemon() async throws -> (PokemonModel?, PokemonServerError)?
    func InfoPokemon(pokeData: Result) async throws -> (PokemonInfoModel?)
    func speciesPokemon(species: String) async throws -> (SpeciesPokemonModel?)
}

enum PokemonServerError {
    case serverError
    case unknownError
    case LoadServerSuccess
}
