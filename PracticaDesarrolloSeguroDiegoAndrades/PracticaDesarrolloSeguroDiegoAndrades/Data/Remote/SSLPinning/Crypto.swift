//
//  Crypto.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 23/5/24.
//

import Foundation
import CryptoKit


enum AESKeySize: Int {
    case bits128 = 16
    case bits192 = 24
    case bits256 = 32
}

public class Crypto {
    // MARK: - Properties
    private let key: String
    
    // MARK: - Init
    init() {
        let keyData: [UInt8] = [0xBE-0x53,0x00+0x65,0x44+0x35,0x2D+0x17,0x20+0x21,0x72-0x23,0x41+0x03,0xAB-0x46,0xA8-0x35,0x21+0x40,0x0A+0x49,0x5A+0x0B,0x71-0x0A]
        guard let unwrappedKey = String(data: Data(keyData), encoding: .utf8) else {
            print("SSLPinning error: unable to obtain local public key")
            self.key = ""
            return
        }
        self.key = unwrappedKey
    }

    // MARK: - Methods
    
    private func paddedKey_PKCS7(from key: String, withSize size: AESKeySize = .bits256) -> Data {
        // Get the data from the key in Bytes
        guard let keyData = key.data(using: .utf8) else { return Data() }
        // If the key is already the right size, return it
        if(keyData.count == size.rawValue) {return keyData}
        // If the key is bigger, truncate it and return it
        if(keyData.count > size.rawValue) {return keyData.prefix(size.rawValue)}
        // If the key is smaller, pad it
        let paddingSize = size.rawValue - keyData.count % size.rawValue
        let paddingByte: UInt8 = UInt8(paddingSize)
        let padding = Data(repeating: paddingByte, count: paddingSize)
        return keyData + padding
    }
    
    
    private func decrypt(input: Data, key: String) -> Data {
        do {
            // Get the correct length key
            let keyData = paddedKey_PKCS7(from: key, withSize: .bits128)
            // Get the symmetric key from the key as a string
            let key = SymmetricKey(data: keyData)
            // Get box from the input, if the data is not a box then throw an error
            let box = try AES.GCM.SealedBox(combined: input)
            // Get the plaintext. If any error occurs during the opening process then throw exception
            let opened = try AES.GCM.open(box, using: key)
            // Return the cipher text
            return opened
        } catch {
            return "Error while decryption".data(using: .utf8)!
        }
    }
    
    public func getDecrypted (data: String) -> String? {
        guard let sealedDataBoxData = Data(base64Encoded: data) else {
            print("Error while decrypting the public key: sealed box is not valid")
            return nil
        }
        let data = decrypt(input: sealedDataBoxData, key: key)
        return String(data: data, encoding: .utf8)
    }
}
