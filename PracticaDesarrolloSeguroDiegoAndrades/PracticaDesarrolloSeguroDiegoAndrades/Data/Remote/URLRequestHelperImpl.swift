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
        // Get URL
        guard let url = URL(string: "\(endpoints.baseURL)\(endpoints.pokemon)") else {
            print("Error while creating URL from \(endpoints.baseURL)\(endpoints.pokemon)")
            return nil
        }
        
        // URL request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
        
        return urlRequest
    }
}