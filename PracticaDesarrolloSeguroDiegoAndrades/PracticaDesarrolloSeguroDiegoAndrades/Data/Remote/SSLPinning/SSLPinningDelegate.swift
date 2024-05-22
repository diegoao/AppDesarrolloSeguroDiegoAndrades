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
    
    let localPublicKeyHashBase64 = "XM/zPZlyGRsb47ZGBJvaZGYVjQvjOrF6u5A5sxyDakk="
}


// MARK: - Funciones URLSessionDelegate
extension SSLPinningDelegate: URLSessionDelegate{
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        //Validamos el servidor
        
        
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
        if serverHashBase64 == self.localPublicKeyHashBase64 {
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

    /// Create a SHA256 representation of the data passed as parameter (crypto kit)
    /// - Parameter data: The data that will be converted to SHA256.
    /// - Returns: The SHA256 representation of data.
    private func sha256CryptoKit(data: Data) -> String {
        let hash = SHA256.hash(data: data)
        return Data(hash).base64EncodedString()
    }

}
