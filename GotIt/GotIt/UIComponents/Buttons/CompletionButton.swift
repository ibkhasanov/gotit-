//
//  CompletionButton.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import Foundation

// MARK: ButtonType
/// Вид кнопки
public enum ButtonType: String, Codable {
    /// Кнопка с бекграундом
    case primary
    /// Кнопка с одним текстом
    case text
}

public protocol CompletionButtonProtocol {
    var content: UCButton.Content { get }
    var type: ButtonType { get }
}

public struct CompletionButton: CompletionButtonProtocol {
    public var content: UCButton.Content
    public var type: ButtonType
    
    public init(content: UCButton.Content, type: ButtonType) {
        self.content = content
        self.type = type
    }
}
