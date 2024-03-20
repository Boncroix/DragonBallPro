//
//  KeyChainStorage.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 16/3/24.
//

import Foundation
import KeychainSwift

protocol SecureDataProtocol {
    func set(token: String)
    func getToken() -> String?
    func deleteToken()
}
//MARK: - SecureData
final class SecureDataKeychain: SecureDataProtocol {
    
    private let keychain = KeychainSwift()
    private let keytoken = ConstantsApp.CONST_TOKEN_ID_KEYCHAIN
    //set
    func set(token: String) {
        keychain.set(token, forKey: keytoken)
    }
    //get
    func getToken() -> String? {
        if let token = keychain.get(keytoken) {
            return token
        } else {
            return ""
        }
        
    }
    //delete
    func deleteToken() {
        keychain.delete(keytoken)
    }
}
//MARK: - FakeSecureData
final class SecureDataUserDefaults: SecureDataProtocol {
    
    private let userDefaults = UserDefaults.standard
    private let keytoken = ConstantsApp.CONST_TOKEN_ID_KEYCHAIN
    //set
    func set(token: String) {
        userDefaults.setValue(token, forKey: keytoken)
    }
    //get
    func getToken() -> String? {
        if let token = userDefaults.value(forKey: keytoken) as? String{
            return token
        } else {
            return ""
        }
    }
    //delete
    func deleteToken() {
        userDefaults.removeObject(forKey: keytoken)
    }
    
    
}
