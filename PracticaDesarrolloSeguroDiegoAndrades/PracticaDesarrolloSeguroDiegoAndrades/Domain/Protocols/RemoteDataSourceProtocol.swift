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
    func pokemon() async throws -> ([PokemonList], PokemonServerError)?
}

enum PokemonServerError {
    case authenticationError
    case serverError
    case unknownError
    case LoadServerSuccess
}
