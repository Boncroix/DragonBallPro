//
//  LoginStatus.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 19/3/24.
//

import Foundation

enum LoginStatus {
    case none
    case success
    case notValidate
    case loading(_ isLoading: Bool)
    case showErrorEmail(_ error: String?)
    case showErrorPassword(_ error: String?)
    case errorNetwork(_ error: String?)
}
