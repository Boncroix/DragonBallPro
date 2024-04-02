//
//  AppState.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 15/3/24.
//

import Foundation
import Combine

final class AppState {
    
    @Published var statusLogin: LoginStatus = .none
    private var loginUseCase: LoginUseCaseProtocol
    
    //MARK: - Inits
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
    }
    
    //MARK: - OnLoginButton
    func onLoginButton(email: String?, password: String?) {
        self.statusLogin = .loading(true)
        
        guard let email = email, isValid(email: email) else {
            self.statusLogin = .showErrorEmail(NSLocalizedString("errorEmail", comment: "ErrorEmail"))
            return
        }
        guard let password = password, isValid(password: password) else {
            self.statusLogin = .showErrorPassword(NSLocalizedString("errorPassword", comment: "ErrorPassword"))
            return
        }
        loginApp(user: email, password: password)
    }
    
    //MARK: - CheckEmail
    private func isValid(email: String) -> Bool {
        email.isEmpty == false && email.contains("@")
    }
    
    //MARK: - CheckPassword
    private func isValid(password: String) -> Bool {
        password.isEmpty == false && password.count >= 4
    }
    
    //MARK: - LoginApp
    public func loginApp(user: String, password: String) {
        Task {
            do {
                if ( try await loginUseCase.loginApp(user: user, password: password)) {
                    self.statusLogin = .success
                }
            } catch {
                let errorMessage = errorMessage(for: error)
                self.statusLogin = .errorNetwork(errorMessage)
            }
        }
    }
    
    //MARK: - ValidateLogin
    func validateControlLogin() {
        Task {
            if (await loginUseCase.validateToken()) {
                self.statusLogin = .success
            } else {
                self.statusLogin = .notValidate
            }
        }
    }
    
    //MARK: - CloseSessionUser
    func closeSessionUser() {
        Task {
            await loginUseCase.logout()
            self.statusLogin = .notValidate
        }
    }
}



