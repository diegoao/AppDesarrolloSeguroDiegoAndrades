//
//  URLRequestHelperProtocol.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 19/5/24.
//

import Foundation
protocol URLRequestHelperProtocol {
    
    // MARK: Properties
    var endpoints: Endpoints { get }

    // MARK: Functions
    func pokemon() -> URLRequest?
}
