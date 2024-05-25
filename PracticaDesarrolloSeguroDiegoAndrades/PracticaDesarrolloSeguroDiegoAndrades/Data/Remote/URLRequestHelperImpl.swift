//
//  URLRequestHelperImpl.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 19/5/24.
//

import Foundation

final class URLRequestHelperImpl: URLRequestHelperProtocol {

    
 
    // MARK: Properties
    
    var endpoints: Endpoints = Endpoints()
    
    // MARK: Functions
    func pokemon() -> URLRequest? {
        let crypto = Crypto()
        guard let baseURL = crypto.getDecrypted(data: String("\(endpoints.baseURL)")),
              let nPokemon = crypto.getDecrypted(data: String("\(endpoints.pokemon)")) else {
            print("Error while creating URL: baseURL or onPokemon is nil")
            return nil
        }
        
        let urlString = baseURL + nPokemon
        
        
        // Get URL
        guard let url = URL(string: urlString) else {
            print("Error while creating URL from \(urlString)")
            return nil
        }
        
        // URL request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
    
        return urlRequest
    }
    
    func infoPokemon(listPoke: Result) -> URLRequest? {
        // Get URL
        let firstData = listPoke.url
        guard let url = URL(string: firstData) else {
            print("Error getting pokemon url")
            return nil
        }
 
        // URL request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
    
    func speciesPokemon(species: String) -> URLRequest? {
        // Get URL
        guard let url = URL(string: species) else {
            print("Error getting pokemon url")
            return nil
        }
        // URL request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
}

