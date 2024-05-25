//
//  RemoteDataSourceImpl.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 19/5/24.
//

import Foundation

final class RemoteDataSourceImpl: RemoteDataSourceProtocol {

    
    var urlRequestHelper: URLRequestHelperProtocol = URLRequestHelperImpl()
    

    func pokemon() async throws -> (PokemonModel?, PokemonServerError)? {
        // Obtenemos la request
        guard let URLRequest = urlRequestHelper.pokemon() else {
            print("Error while creating the URLRequest for the Pokemon")
            return nil
        }
        
        // Get data and response from the server
        let (data, response) = try await URLSession.shared.data(for: URLRequest)
    
        
        // Transform the response into a HTTPURLResponse to access the status code
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Error while casting the response to HTTPURLResponse")
            return nil
        }
        let statusCode = httpResponse.statusCode
         
        // Check the status code
        switch statusCode {
            
        // If the status code is 200, return list pokemon, print pokemon fetching success
        case 200:
            // Convert the data into a array of pokemon and return it
            guard let dataPokemon = try? JSONDecoder().decode(PokemonModel.self, from: data) else {
                print("Error: error while decoding the response from the server")
                return nil
            }
            return (dataPokemon, .LoadServerSuccess)
        // If the status code is 400, return nil, print bad request error
        case 400:
            print("Bad request error while fetching pokemon from the API")
            return nil
        // If the status code is 401, return nil, print auth error
        case 401:
            print("Authentication error while fetching pokemon from the API")
            return nil
        // If the status code is 500, return nil print server error
        case 500:
            print("Server error while fetching pokemon from the API")
            return nil
        // If the status code is unknown, return (nil, unknownError)
        default:
            print("Unknown error while fetching pokemon from the API")
            return nil
        }
    }
    
    func InfoPokemon(pokeData: Result) async throws -> (PokemonInfoModel?) {
        // Obtenemos la request
        guard let URLRequest = urlRequestHelper.infoPokemon(listPoke: pokeData)  else {
            print("Error while creating the URLRequest for the Pokemon")
            return nil
        }
        
        // Get data and response from the server
        let (data, response) = try await URLSession.shared.data(for: URLRequest)
    
        
        // Transform the response into a HTTPURLResponse to access the status code
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Error while casting the response to HTTPURLResponse")
            return nil
        }
        let statusCode = httpResponse.statusCode
         
        // Check the status code
        switch statusCode {
            
        // If the status code is 200, return list pokemon, print pokemon fetching success
        case 200:
            // Convert the data into a array of pokemon and return it
            guard let dataInfoPokemon = try? JSONDecoder().decode(PokemonInfoModel.self, from: data) else {
                print("Error: error while decoding the response from the server")
                return nil
            }
            return (dataInfoPokemon)
        // If the status code is 400, return nil, print bad request error
        case 400:
            print("Bad request error while fetching pokemon from the API")
            return nil
        // If the status code is 401, return nil, print auth error
        case 401:
            print("Authentication error while fetching pokemon from the API")
            return nil
        // If the status code is 500, return nil print server error
        case 500:
            print("Server error while fetching pokemon from the API")
            return nil
        // If the status code is unknown, return (nil, unknownError)
        default:
            print("Unknown error while fetching pokemon from the API")
            return nil
        }
    }
    
    func speciesPokemon(species: String) async throws -> (SpeciesPokemonModel?) {
        // Obtenemos la request
        guard let URLRequest = urlRequestHelper.speciesPokemon(species: species)  else {
            print("Error while creating the URLRequest for the pokemon")
            return nil
        }
        
        // Get data and response from the server
        let (data, response) = try await URLSession.shared.data(for: URLRequest)
    
        
        // Transform the response into a HTTPURLResponse to access the status code
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Error while casting the response to HTTPURLResponse")
            return nil
        }
        let statusCode = httpResponse.statusCode
         
        // Check the status code
        switch statusCode {
            
        // If the status code is 200, return list pokemon, print pokemon fetching success
        case 200:
            // Convert the data into a array of pokemon and return it
            guard let speciesInfoPokemon = try? JSONDecoder().decode(SpeciesPokemonModel.self, from: data) else {
                print("Error: error while decoding the response from the server")
                return nil
            }
            return (speciesInfoPokemon)
        // If the status code is 400, return nil, print bad request error
        case 400:
            print("Bad request error while fetching pokemon from the API")
            return nil
        // If the status code is 401, return nil, print auth error
        case 401:
            print("Authentication error while fetching pokemon from the API")
            return nil
        // If the status code is 500, return nil print server error
        case 500:
            print("Server error while fetching pokemon from the API")
            return nil
        // If the status code is unknown, return (nil, unknownError)
        default:
            print("Unknown error while fetching pokemon from the API")
            return nil
        }
    }
    
}
