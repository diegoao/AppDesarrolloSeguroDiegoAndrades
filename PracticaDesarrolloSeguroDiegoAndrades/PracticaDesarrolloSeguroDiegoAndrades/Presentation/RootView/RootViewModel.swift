//
//  RootViewModel.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 19/5/24.
//

import Foundation

enum Status {
    case none, loading, loaded
}

enum PokemonError {
    case serverError
    case unknownError
    case none
}

final class RootViewModel: ObservableObject {
    
    // MARK: Properties
    let repository: RepositoryProtocol
    @Published var status = Status.none


    // MARK: Init
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
        
    // MARK: Functions
    func onPokemon(completion: ((PokemonError) -> Void)?) async {
        
        do {
            if let (pokelist, pokemonError) = try await repository.pokemon() {
                switch pokemonError {
                case .serverError:
                    completion?(.serverError)
                case .unknownError:
                    completion?(.unknownError)
                case .LoadServerSuccess:
                    print(pokelist ?? "")
                    completion?(.none)
                }
            }
        } catch {
            print("Error while login in onLogin catch block")
            completion?(.unknownError)
        }
    }
}
