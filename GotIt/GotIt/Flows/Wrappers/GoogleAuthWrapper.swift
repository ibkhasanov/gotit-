//
//  GoogleAuthWrapper.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

protocol GoogleAuthWrapperProtocol {
    func auth(completionHandler: @escaping ((String?, String?) -> ()))
}

final class GoogleAuthWrapper: GoogleAuthWrapperProtocol {
    func auth(completionHandler: @escaping ((String?, String?) -> ())) {
        completionHandler("google_login", "google_password")
    }
}
