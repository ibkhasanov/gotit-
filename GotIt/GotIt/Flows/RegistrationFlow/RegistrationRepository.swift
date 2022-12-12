//
//  RegistrationRepository.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

typealias RegistrationUnionRepositoryProtocol = RegistrationRequestRepositoryProtocol & RegistrationLocalRepositoryProtocol

protocol RegistrationRequestRepositoryProtocol {
    func authRequest(email: String, password: String, completionHandler: @escaping ((Bool?, NSError?) -> ()))
}

protocol RegistrationLocalRepositoryProtocol {
    
}

final class RegistrationRepository: RegistrationUnionRepositoryProtocol {
    private let authApi: APIWrappersProtocol
    
    init(authApi: APIWrappersProtocol) {
        self.authApi = authApi
    }
    
    func authRequest(email: String,
                     password: String,
                     completionHandler: @escaping ((Bool?, NSError?) -> ())) {
        self.authApi.authRequest(email: email,
                                 password: password,
                                 completionHandler: completionHandler)
    }
}
