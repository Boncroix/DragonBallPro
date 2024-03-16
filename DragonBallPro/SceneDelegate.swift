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
    var appState: AppState = AppState(loginUseCase: LoginUseCase())
    var cancelable: AnyCancellable?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        
        appState.validateControlLogin()
        
        var nav: UINavigationController?
        
        self.cancelable = appState.$statusLogin
            .sink(receiveValue: { estado in
                switch estado {
                case .notValidate, .none:
                    DispatchQueue.main.async {
                        nav = UINavigationController(rootViewController: LoginViewController(appState: self.appState))
                        self.window?.rootViewController = nav
                        self.window?.makeKeyAndVisible()
                    }
                case .success:
                    //la home
                    print("vamos pal home")
                case .error:
                    //error
                    print("vamos pal error")
                }
            })
    }
}

