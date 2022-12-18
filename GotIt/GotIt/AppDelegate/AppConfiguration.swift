//
//  AppConfiguration.swift
//  GotIt
//
//  Created by user on 18.12.2022.
//

import UIKit
import FirebaseCore

protocol AppConfigurationProtocol {
    func configure()
}

final class AppConfiguration: AppConfigurationProtocol {
    func configure() {
        FirebaseApp.configure()
    }
}
