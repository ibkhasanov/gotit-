//
//  FirebaseAPIWrappers.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

protocol APIWrappersProtocol {
    func authRequest(email: String, password: String, completionHandler: @escaping ((Bool?, NSError?) -> ()))
}

final class FirebaseAPIWrappers: APIWrappersProtocol {
    func authRequest(email: String,
                     password: String,
                     completionHandler: @escaping ((Bool?, NSError?) -> ())) {
        completionHandler(true, nil)
    }
}
