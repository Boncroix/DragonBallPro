//
//  SceneDelegate.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 15/3/24.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var appState: AppState = AppState(loginUseCase: LoginUseCase())
    private var cancelable: AnyCancellable?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        
        appState.validateControlLogin()
        
        //MARK: - Binding AppState
        self.cancelable = appState.$statusLogin
            .sink(receiveValue: { [weak self] status in
                guard let self = self else { return }

                func setRootViewController(_ viewController: UIViewController) {
                    let nav = UINavigationController(rootViewController: viewController)
                    self.window?.rootViewController = nav
                    self.window?.makeKeyAndVisible()
                }

                switch status {
                case .notValidate, .none:
                    DispatchQueue.main.async {
                        setRootViewController(LoginViewController(appState: self.appState))
                    }
                case .success:
                    DispatchQueue.main.async {
                        setRootViewController(HerosViewController(appState: self.appState, viewModel: HeroesViewModel()))
                    }
                default:
                    break
                }
            })
    }
}

