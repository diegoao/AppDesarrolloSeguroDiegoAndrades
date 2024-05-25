//
//  RootViewModel.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 19/5/24.
//

import Foundation
import LocalAuthentication

enum Status {
    case none, loading, loaded
}

enum PokemonError {
    case serverError
    case unknownError
    case none
}

final class RootViewModel: ObservableObject {
    @Published var listInfoPokemon: [PokemonInfoModel] = []
    
    // MARK: Properties
    let repository: RepositoryProtocol
    @Published var status = Status.none
    let authentication: Authentication


    // MARK: Init
    init(repository: RepositoryProtocol) {
        self.repository = repository
        self.authentication = Authentication(context: LAContext())
    }
        
    // MARK: Functions
    func onPokemon(completion: ((PokemonError) -> Void)?) async -> [PokemonModel]{
        var datos : [PokemonModel] = []
        do {
            if let (pokelist, pokemonError) = try await repository.pokemon() {
                switch pokemonError {
                case .serverError:
                    completion?(.serverError)
                case .unknownError:
                    completion?(.unknownError)
                case .LoadServerSuccess:
                    datos.append(pokelist!)
                    completion?(.none)
                }
            }
        } catch {
            print("Error reading data from the Pokemon API")
            completion?(.unknownError)
        }
        return datos
    }
 
    func onListPokemon(dataPoke: Result) async -> PokemonInfoModel{
        var datos: PokemonInfoModel? = nil
        do {
            if let pokelist = try await repository.InfoPokemon(pokeData: dataPoke) {
                    datos = pokelist
                }
            
        } catch {
            print("Error reading data from the Pokemon API List")
        }
        return datos!
    }
    
    func onSpeciesPokemon(species: String) async -> SpeciesPokemonModel{
        var datos: SpeciesPokemonModel? = nil
        do {
            if let speciesList = try await repository.speciesPokemon(species: species){
                    datos = speciesList
                }
            
        } catch {
            print("Error reading data from the Pokemon API List")
        }
        return datos!
    }
}
