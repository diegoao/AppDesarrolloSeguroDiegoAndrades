//
//  RepositoryProtocol.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 19/5/24.
//

import Foundation

protocol RepositoryProtocol {
    
    // MARK: Properties
    var remoteDataSource: RemoteDataSourceProtocol { get }
    
    // MARK: Functions
    func pokemon() async throws -> (PokemonModel?, PokemonServerError)?
    func InfoPokemon(pokeData: Result) async throws -> (PokemonInfoModel?)
}
