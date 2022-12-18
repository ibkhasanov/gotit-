//
//  NetworkErrorType.swift
//  GotIt
//
//  Created by user on 18.12.2022.
//

import Foundation

protocol NetworkErrorType {
    var title: String? { get }
    var message: String? { get }
    var code: Int? { get }
}

struct NetworkError: NetworkErrorType {
    var title: String?
    var message: String?
    var code: Int?
    
    init(error: NSError?) {
        self.title = "Oops..."
        if let _error = error {
            self.message = _error.localizedDescription
            self.code = _error.code
        } else {
            self.message = "Error"
            self.code = 2
        }
    }
}
