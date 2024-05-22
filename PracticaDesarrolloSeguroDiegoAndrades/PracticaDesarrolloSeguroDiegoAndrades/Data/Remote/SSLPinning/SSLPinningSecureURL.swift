//
//  SSLPinningSecureURL.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 22/5/24.
//

import Foundation

class SSLPinningSecureURL{
    
    //No se inicializa para tener control sobre ella
    let session: URLSession
    
    init() {
        self.session = URLSession(configuration: .ephemeral, delegate: SSLPinningDelegate(), delegateQueue: nil)
    }
}

    //Reemplazamos el shared por nuestra session
extension URLSession{
    static var shared: URLSession{
        SSLPinningSecureURL().session
    }
}
