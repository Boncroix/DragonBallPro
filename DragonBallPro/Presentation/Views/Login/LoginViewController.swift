//
//  LoginViewController.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 16/3/24.
//

import UIKit
import Combine
import CombineCocoa

final class LoginViewController: UIViewController {
    
    private var appState: AppState
    private var suscriptors = Set<AnyCancellable>()
    private var user: String = ""
    private var pass: String = ""
    private var cancelable: AnyCancellable?
    
    //MARK: - IBOutlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblErrorPassword: UILabel!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var constraintBoottomLoginButton: NSLayoutConstraint!
    
    //MARK: - Inits
    init(appState: AppState) {
        self.appState = appState
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingUI()
        showStatus()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hidenKeyboard))
        self.view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changedFrameKeyboard(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - BindingUI
extension LoginViewController {
    private func bindingUI() {
        if let txtEmail = self.txtEmail {
            txtEmail.textPublisher
                .receive(on: DispatchQueue.main)
                .sink { data in
                    if let user = data {
                        self.user = user
                    }
                }
                .store(in: &suscriptors)
        }
        if let txtPassword = self.txtPassword {
            txtPassword.textPublisher
                .receive(on: DispatchQueue.main)
                .sink { data in
                    if let pass = data {
                        self.pass = pass
                    }
                }
                .store(in: &suscriptors)
        }
        if let loginButton = self.buttonLogin {
            loginButton.tapPublisher
                .sink { [weak self] _ in
                    if let user = self?.user,
                       let pass = self?.pass {
                        self?.appState.onLoginButton(email: user, password: pass)
                    }
                }
                .store(in: &suscriptors)
        }
    }
}

// MARK: - Binding con AppState
extension LoginViewController {
    /// Gestión vista de errores
    private func showStatus() {
        self.cancelable = appState.$statusLogin
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] status in
                switch status {
                case.loading(_):
                    self?.lblErrorPassword.isHidden = true
                    self?.loadingView.isHidden = false
                    self?.lblEmailError.isHidden = true
                    
                case .showErrorEmail(let error):
                    self?.loadingView.isHidden = true
                    self?.lblEmailError.text = error
                    self?.lblEmailError.isHidden = false
                    
                case .showErrorPassword(let error):
                    self?.loadingView.isHidden = true
                    self?.lblErrorPassword.text = error
                    self?.lblErrorPassword.isHidden = false
                    
                case .errorNetwork(let errorMessage):
                    self?.loadingView.isHidden = true
                    self?.showAlert(message: errorMessage ?? "")
                    
                default: break
                }
            })
    }
}

//MARK: - ConfigUI
extension LoginViewController {
    /// Botón para mostrar contraseña
    private func configUI() {
        let showPasswordButton = UIButton(type: .system)
        showPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        showPasswordButton.tintColor = UIColor.blueAndRed
        showPasswordButton.addTarget(self, action: #selector(didTapShowPasswordButton),
                                     for: [.touchDown, .touchUpInside])
        txtPassword.rightView = showPasswordButton
        txtPassword.rightViewMode = .always
    }
}
// MARK: - Alert
extension LoginViewController {
    /// Crear alert para el networkError
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "ERROR NETWORK", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
//MARK: - Objc
extension LoginViewController {
    /// Ocultar teclado
    @objc func hidenKeyboard() {
        self.view.endEditing(true)
    }
    
    /// Cambiar constraint inferior cuando el teclado está fuera
    @objc func changedFrameKeyboard(notification: Notification) {
        let userInfo = notification.userInfo
        let frame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let delta = UIScreen.main.bounds.size.height - (frame?.origin.y ?? 0)
        self.constraintBoottomLoginButton.constant = delta

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    /// Mostrar contraseña
    @objc func didTapShowPasswordButton(sender: UIButton) {
        txtPassword.isSecureTextEntry.toggle()
    }
}
