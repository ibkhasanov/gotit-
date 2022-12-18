//
//  EmulateSplashViewModel.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit
import Foundation
import Bond
import ReactiveKit

protocol RegistrationViewModelProtocol {
    /// Лого
    var image: UIImage? { get }
    /// Сообщение
    var message: String { get }
    /// Условия
    var agreements: String { get }
    /// Состояния
    var state: PassthroughSubject<RegistrationViewController.State, Never> { get }
    /// ViewDidLoad
    func viewDidLoad()
}


final class RegistrationViewModel: RegistrationViewModelProtocol {
    var image: UIImage?
    var message: String
    var agreements: String
    var state = PassthroughSubject<RegistrationViewController.State, Never>.init()
    private let repository: RegistrationUnionRepositoryProtocol
    private let emailTitle: String
    private let appleTitle: String
    private let facebookTitle: String
    private let googleTitle: String
    private var coordinator: RegistrationCoordinatorProtocol
    private var appleAuthWrapper: AppleAuthWrapperProtocol
    private let googleAuthWrapper: GoogleAuthWrapperProtocol
    private let facebookAuthWrapper: FacebookAuthWrapperProtocol
    
    init(image: UIImage?,
         message: String,
         agreements: String,
         repository: RegistrationUnionRepositoryProtocol,
         emailTitle: String,
         appleTitle: String,
         facebookTitle: String,
         googleTitle: String,
         coordinator: RegistrationCoordinatorProtocol,
         appleAuthWrapper: AppleAuthWrapperProtocol,
         googleAuthWrapper: GoogleAuthWrapperProtocol,
         facebookAuthWrapper: FacebookAuthWrapperProtocol) {
        self.image = image
        self.message = message
        self.agreements = agreements
        self.repository = repository
        self.emailTitle = emailTitle
        self.appleTitle = appleTitle
        self.facebookTitle = facebookTitle
        self.googleTitle = googleTitle
        self.coordinator = coordinator
        self.appleAuthWrapper = appleAuthWrapper
        self.googleAuthWrapper = googleAuthWrapper
        self.facebookAuthWrapper = facebookAuthWrapper
    }
    
    func viewDidLoad() {
        let content = self.makeContent()
        self.state.send(.content(data: content))
    }
}

extension RegistrationViewModel {
    private func makeContent() -> RegistrationViewController.Content {
        let content = RegistrationViewController.Content(emailButton: self.makeEmailButton(),
                                                         appleButton: self.makeAppleButton(),
                                                         googleButton: self.makeGoogleButton(),
                                                         facebookButton: self.makeFacebookButton())
        return content
    }
    
    /// Нажатие на кнопку почта
    private func makeEmailButton() -> UCBaseButton.Content {
        let actionHandler = ActionHandler({ [weak self] in
            guard let _self = self else { return }
            _self.coordinator.toEmail = true
            _self.coordinator.finishActionFlow()
        })
        return UCButton.Content(title: self.emailTitle,
                                isEnabled: true,
                                actionHandler: actionHandler)
    }
    
    /// Нажатие на кнопку apple
    private func makeAppleButton() -> UCBaseButton.Content {
        let actionHandler = ActionHandler({ [weak self] in
            guard let _self = self else { return }
            _self.appleAuthWrapper.auth()
            _self.appleAuthWrapper.delegate = _self
        })
        return UCButton.Content(title: self.appleTitle,
                                isEnabled: true,
                                actionHandler: actionHandler)
    }
    
    /// Нажатие на кнопку google
    private func makeGoogleButton() -> UCBaseButton.Content {
        let actionHandler = ActionHandler({ [weak self] in
            guard let _self = self else { return }
            _self.googleAuthWrapper.auth { [weak self] email, password in
                guard let _self = self, let _email = email, let _password = password else { return }
                _self.authRequest(_email, password: _password)
            }
        })
        return UCButton.Content(title: self.googleTitle,
                                isEnabled: true,
                                actionHandler: actionHandler)
    }
    
    /// Нажатие на кнопку facebook
    private func makeFacebookButton() -> UCBaseButton.Content {
        let actionHandler = ActionHandler({ [weak self] in
            guard let _self = self else { return }
            _self.facebookAuthWrapper.auth { [weak self] email, password in
                guard let _self = self, let _email = email, let _password = password else { return }
                _self.authRequest(_email, password: _password)
            }
        })
        return UCButton.Content(title: self.facebookTitle,
                                isEnabled: true,
                                actionHandler: actionHandler)
    }
    
    
}

extension RegistrationViewModel: AppleAuthWrapperDelegate {
    func complete(email: String?,
                  password: String?,
                  error: Error?) {
        if let _email = email, let _password = password {
            self.authRequest(_email, password: _password)
        } else {
            self.state.send(.error(data: NetworkError(error: nil)))
        }
    }
    
    func authRequest(_ email: String, password: String) {
        self.state.send(.loading(isActive: true))
        self.repository.authRequest(email: email,
                                    password: password) { [weak self] success, error in
            guard let _self = self else { return }
            _self.state.send(.loading(isActive: false))
            if let _success = success, _success {
                _self.coordinator.success = true
                _self.coordinator.finishActionFlow()
            } else if let _error = error {
                _self.state.send(.error(data: NetworkError(error: _error)))
            } else {
                _self.state.send(.error(data: NetworkError(error: nil)))
            }
        }
    }
}
