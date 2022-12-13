//
//  EmulateSplashViewModel.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit
import Foundation

protocol RegistrationViewModelProtocol {
    /// Лого
    var image: UIImage? { get }
    /// Сообщение
    var message: String { get }
    /// Условия
    var agreements: String { get }
    /// ViewDidLoad
    func viewDidLoad()
}


final class RegistrationViewModel: RegistrationViewModelProtocol {
    var image: UIImage?
    var message: String
    var agreements: String
    private let repository: RegistrationUnionRepositoryProtocol
    private let emailTitle: String
    private let appleTitle: String
    private let facebookTitle: String
    private let googleTitle: String
    private var coordinator: RegistrationCoordinatorProtocol
    
    init(image: UIImage?,
         message: String,
         agreements: String,
         repository: RegistrationUnionRepositoryProtocol,
         emailTitle: String,
         appleTitle: String,
         facebookTitle: String,
         googleTitle: String,
         coordinator: RegistrationCoordinatorProtocol) {
        self.image = image
        self.message = message
        self.agreements = agreements
        self.repository = repository
        self.emailTitle = emailTitle
        self.appleTitle = appleTitle
        self.facebookTitle = facebookTitle
        self.googleTitle = googleTitle
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
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
        })
        return UCButton.Content(title: self.appleTitle,
                                isEnabled: true,
                                actionHandler: actionHandler)
    }
    
    /// Нажатие на кнопку google
    private func makeGoogleButton() -> UCBaseButton.Content {
        let actionHandler = ActionHandler({ [weak self] in
            guard let _self = self else { return }
        })
        return UCButton.Content(title: self.googleTitle,
                                isEnabled: true,
                                actionHandler: actionHandler)
    }
    
    /// Нажатие на кнопку facebook
    private func makeFacebookButton() -> UCBaseButton.Content {
        let actionHandler = ActionHandler({ [weak self] in
            guard let _self = self else { return }
        })
        return UCButton.Content(title: self.facebookTitle,
                                isEnabled: true,
                                actionHandler: actionHandler)
    }
    
    
}
