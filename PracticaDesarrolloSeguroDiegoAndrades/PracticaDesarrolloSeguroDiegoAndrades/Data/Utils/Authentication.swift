//
//  Authentication.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 24/5/24.
//

import Foundation
import LocalAuthentication

class Authentication {
    
    //MARK: Propiedades
    private let context: LAContext
    private var error: NSError?
    
    //MARK: Inicializador
    init(context: LAContext) {
        self.context = context
    }
    
    //MARK: Métodos
    func authenticateUser(completion: @escaping (Bool)-> Void){
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let razon = "Identificarse para obtener los datos"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: razon){ succes, error in
                DispatchQueue.main.async {
                    completion(succes)
                }
            }
        }
    }
}
