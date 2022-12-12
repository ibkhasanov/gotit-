//
//  AppleAuthWrapper.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

protocol AppleAuthWrapperProtocol {
    func auth(completionHandler: @escaping ((String?, String?) -> ()))
}

final class AppleAuthWrapper: AppleAuthWrapperProtocol {
    func auth(completionHandler: @escaping ((String?, String?) -> ())) {
        
    }
}
