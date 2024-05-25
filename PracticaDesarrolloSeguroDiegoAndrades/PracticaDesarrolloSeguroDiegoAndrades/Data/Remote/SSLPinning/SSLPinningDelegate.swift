//
//  SSLPinningDelegate.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 22/5/24.
//

import Foundation
import CryptoKit
import CommonCrypto

class SSLPinningDelegate: NSObject{
    // Instanciamos la clase Crypto
    private var crypto = Crypto()
    
    //Inilizalizamos 
    override init() {
        self.crypto =  Crypto()
    }
}


// MARK: - Funciones URLSessionDelegate
extension SSLPinningDelegate: URLSessionDelegate{
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

        
        
        //Obtengo el server trust
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            //SERVIDOR VÁLIDO(PUBLIC KEY NO COINCIDE)
            completionHandler(.cancelAuthenticationChallenge, nil)
            print("SSLPinnig Error: Server no retorna el trust")
            return
        }
        
        
        //Obtengo el certificado
        let serverCertificates: [SecCertificate]?
        serverCertificates = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate]
        guard let serverCertificate = serverCertificates?.first else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            print("SSLPinnig Error: Certificado es nil")
            return
        }
        
        //Obtengo la public Key
        guard let serverPublicKey = SecCertificateCopyKey(serverCertificate) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            print("SSLPinnig Error: Public key es nil")
            return
        }
        
        //Transformamos la public keu del servidor a data
        guard let serverPublicKeyRep = SecKeyCopyExternalRepresentation(serverPublicKey, nil) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            print("SSLPinnig Error: No se ha podido convertir public key a data")
            return
        }
        
        let serverPublicKeyData: Data = serverPublicKeyRep as Data
        
        
        //Convertir la public key data a sha 256 base64
        let serverHashBase64 = sha256CryptoKit(data: serverPublicKeyData)
        
        
        //Compruebo que la clave pública local es igual que la del servidor
        if serverHashBase64 == self.crypto.getDecrypted(data: "w2iZ7rjQIgtsWj7JJz8MHBHLQoCFErr36W0+UfuomDikiV8P3HjRNW7w9zLUDhX5WQx0v3PK3kaCd6ujGXgw8D7U2bYDz5bB") {
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
            print("Filtro SSLPinnig pasado")
        }else{
            completionHandler(.cancelAuthenticationChallenge, nil)
            print("SSLPinnig Error: Server Public Key no coincide")
        }

    }
}

//MARK: - SSLPinning extension: SHA
extension SSLPinningDelegate{

    private func sha256CryptoKit(data: Data) -> String {
        let hash = SHA256.hash(data: data)
        return Data(hash).base64EncodedString()
    }

}


 //MARK: - Ofuscación

extension SSLPinningDelegate {
    
    func obfuscacionPublickey(publicKey: [UInt8]) -> String {
        
        publicKey.reduce("") { (result, character) -> String in
            let comma = result == "" ? "" : ","
            let numberFrom0ToChar = UInt8(Int.random(in: 0...Int(character)))
            switch Int.random(in: 0...1){
            case 0:
                let numberToChar = character - numberFrom0ToChar
                return "\(result)\(comma)\(String(format: "0x%02x", numberFrom0ToChar))\(String(format: "+0x%02x", numberToChar))"
            default:
                return "\(result)\(comma)\(String(format: "0x%02x", character + numberFrom0ToChar))\(String(format: "-0x%02x", numberFrom0ToChar))"
            }
        }
    }
    func desofuscarPublicKey(publicKey: [UInt8]) -> String {
        guard let desofuscarPublicKey = String(data: Data(publicKey), encoding: .utf8) else {
            print("Error desofuscando la publicKey")
            return ("")
        }
        return desofuscarPublicKey
    }
}


