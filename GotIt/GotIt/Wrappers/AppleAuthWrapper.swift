//
//  AppleAuthWrapper.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit
import AuthenticationServices

protocol AppleAuthWrapperProtocol {
    var delegate: AppleAuthWrapperDelegate? { get set }
    func auth()
}

protocol AppleAuthWrapperDelegate: AnyObject {
    func complete(email: String?, password: String?, error: Error?)
}

final class AppleAuthWrapper: NSObject, AppleAuthWrapperProtocol {
    weak var delegate: AppleAuthWrapperDelegate?
    
    
    func auth() {
        self.appleIdRequest()
    }
    
    private func appleIdRequest() {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }
    }
}

extension AppleAuthWrapper: ASAuthorizationControllerDelegate {
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let email = appleIDCredential.email
            self.delegate?.complete(email: email, password: UUID().uuidString, error: nil)
            
        }
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.delegate?.complete(email: nil, password: nil, error: error)
    }
}
