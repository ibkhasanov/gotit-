//
//  FacebookAuthWrapper.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

protocol FacebookAuthWrapperProtocol {
    func auth(completionHandler: @escaping ((String?, String?) -> ()))
}

final class FacebookAuthWrapper: FacebookAuthWrapperProtocol {
    func auth(completionHandler: @escaping ((String?, String?) -> ())) {
        completionHandler("facebok_login@mail.com", UUID().uuidString)
    }
}
