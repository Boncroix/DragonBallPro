//
//  LoginViewController.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 16/3/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
