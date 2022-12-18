//
//  FirebaseAPIWrappers.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit
import FirebaseAuth

protocol APIWrappersProtocol {
    func authRequest(email: String, password: String, completionHandler: @escaping ((Bool?, NSError?) -> ()))
}

final class FirebaseAPIWrappers: APIWrappersProtocol {
    func authRequest(email: String,
                     password: String,
                     completionHandler: @escaping ((Bool?, NSError?) -> ())) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let _ = authResult {
                completionHandler(true, nil)
            } else {
                completionHandler(false, NSError(domain: "gotit.error.com", code: 2))
            }
        }
    }
}
