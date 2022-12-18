//
//  EmailRegistrationViewModel.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit
import Foundation
import Bond
import ReactiveKit

protocol EmailRegistrationViewModelProtocol {
    /// Лого
    var image: UIImage? { get }
    /// Сообщение
    var message: String { get }
    /// Условия
    var agreements: String { get }
    /// Состояния
    var state: PassthroughSubject<EmailRegistrationViewController.State, Never> { get }
    /// ViewDidLoad
    func viewDidLoad()
}

extension EmailRegistrationViewModel {
    /// Состояние данных
    struct State {
        var email: String?
        var password: String?
        var confirmPassword: String?
        var allValid: Bool
        
        init(email: String? = nil,
             password: String? = nil,
             confirmPassword: String? = nil,
             allValid: Bool = false) {
            self.email = email
            self.password = password
            self.confirmPassword = confirmPassword
            self.allValid = allValid
        }
    }
}

final class EmailRegistrationViewModel: EmailRegistrationViewModelProtocol {
    var image: UIImage?
    var message: String
    var agreements: String
    var state = PassthroughSubject<EmailRegistrationViewController.State, Never>.init()
    private let repository: RegistrationUnionRepositoryProtocol
    private var currentState: State
    private let confirmTitle: String
    private var coordinator: EmailRegistrationCoordinatorProtocol
    
    init(image: UIImage?,
         message: String,
         agreements: String,
         repository: RegistrationUnionRepositoryProtocol,
         currentState: State,
         confirmTitle: String,
         coordinator: EmailRegistrationCoordinatorProtocol) {
        self.image = image
        self.message = message
        self.agreements = agreements
        self.repository = repository
        self.currentState = currentState
        self.confirmTitle = confirmTitle
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        let content = self.makeContent()
        self.state.send(.content(data: content))
        let confirmContent = self.makeConfirmButton()
        self.state.send(.confirmContent(data: confirmContent))
    }
}

extension EmailRegistrationViewModel {
    /// Создать контент
    /// - Returns: EmailRegistrationViewController.Content
    private func makeContent() -> EmailRegistrationViewController.Content {
        let content = EmailRegistrationViewController.Content(email: self.makeEmailContent(),
                                                              password: self.makePasswordContent(),
                                                              confirmPassword: self.makeConfirmPasswordContent())
        return content
    }
    
    /// Создать поле Email
    /// - Returns: InputText.Content
    private func makeEmailContent() -> InputText.Content {
        return InputText.Content(title: "Email",
                                 placeholder: "example@email.com",
                                 value: self.currentState.email,
                                 comment: nil,
                                 keyboardType: .emailAddress,
                                 regularExpression: nil,
                                 enabledEdit: true,
                                 errorState: false,
                                 clearButton: nil,
                                 clearAction: nil,
                                 didBeginEditing: nil,
                                 changeValue: { [weak self] value in
            guard let _self = self else { return }
            _self.currentState.email = value
            _self.validateButton()
        },
                                 didEndEditing: nil)
    }
    
    /// Создать поле Password
    /// - Returns: InputText.Content
    private func makePasswordContent() -> InputText.Content {
        return InputText.Content(title: "Password",
                                 placeholder: "********",
                                 value: self.currentState.password,
                                 comment: nil,
                                 keyboardType: .default,
                                 regularExpression: nil,
                                 enabledEdit: true,
                                 errorState: false,
                                 clearButton: nil,
                                 clearAction: nil,
                                 didBeginEditing: nil,
                                 changeValue: { [weak self] value in
            guard let _self = self else { return }
            _self.currentState.password = value
            _self.validateButton()
        },
                                 didEndEditing: nil)
    }
    
    /// Создать поле Repeat Password
    /// - Returns: InputText.Content
    private func makeConfirmPasswordContent() -> InputText.Content {
        return InputText.Content(title: "Repeat password",
                                 placeholder: "********",
                                 value: self.currentState.confirmPassword,
                                 comment: nil,
                                 keyboardType: .default,
                                 regularExpression: nil,
                                 enabledEdit: true,
                                 errorState: false,
                                 clearButton: nil,
                                 clearAction: nil,
                                 didBeginEditing: nil,
                                 changeValue: { [weak self] value in
            guard let _self = self else { return }
            _self.currentState.confirmPassword = value
            _self.validateButton()
        },
                                 didEndEditing: nil)
    }
    
    /// Создать кнопку
    /// - Returns: UCButton.Content
    private func makeConfirmButton() -> UCButton.Content {
        let actionHandler = ActionHandler({ [weak self] in
            guard let _self = self else { return }
            _self.authRequest()
        })
        return UCButton.Content(title: self.confirmTitle,
                                isEnabled: self.currentState.allValid,
                                actionHandler: actionHandler)
    }
}

extension EmailRegistrationViewModel {
    /// Валидация кнопки
    private func validateButton() {
        let valid = self.checkAllValid()
        if self.currentState.allValid != valid {
            self.currentState.allValid = valid
            let content = self.makeConfirmButton()
            self.state.send(.confirmContent(data: content))
        }
    }
    
    /// Проверка валидности всех полей
    /// - Returns: Bool
    private func checkAllValid() -> Bool {
        let email = self.currentState.email?.count ?? 0 > 1
        let password = self.currentState.password?.count ?? 0 > 1
        let confirmPassword = self.currentState.password == self.currentState.confirmPassword
        return email && password && confirmPassword
    }
}

extension EmailRegistrationViewModel {
    /// Запрос на регистрацию
    func authRequest() {
        self.state.send(.loading(isActive: true))
        self.repository.authRequest(email: self.currentState.email ?? "",
                                    password: self.currentState.password ?? "") { [weak self] success, error in
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
