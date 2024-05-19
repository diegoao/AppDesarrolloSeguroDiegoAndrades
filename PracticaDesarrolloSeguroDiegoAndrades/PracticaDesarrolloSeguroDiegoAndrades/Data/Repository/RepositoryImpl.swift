//
//  RepositoryImpl.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 19/5/24.
//

final class RepositoryImpl: RepositoryProtocol {

    // MARK: Properties
    var remoteDataSource: RemoteDataSourceProtocol
    
    // MARK: Init
    init(remoteDataSource: RemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    // MARK: Functions
    func pokemon() async throws -> (PokemonModel?, PokemonServerError)? {
        return try await remoteDataSource.pokemon()
    }
}
