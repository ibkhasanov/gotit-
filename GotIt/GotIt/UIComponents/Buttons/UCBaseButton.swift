//
//  UCBaseButton.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

extension UIControl.State: Hashable { }

open class UCBaseButton: UIButton {
    
    public var content: Content? {
        didSet {
            if oldValue?.icon != self.content?.icon {
                self.setImage(self.content?.icon, for: .normal)
            }
            if oldValue?.title != self.content?.title {
                self.update(self.content?.title)
            }
            if oldValue?.isEnabled != self.content?.isEnabled {
                self.isEnabled = self.content?.isEnabled ?? true
            }
            self.addTargetIfNeeded()
        }
    }
 
    private var isSubscribed: Bool = false
    
    /// установка заголовка для кнопки
    /// - Parameter title: текст
    func update(_ title: String?) {
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .disabled)
    }
    
    @objc
    private func touchUpInside() {
        self.content?.callback?()
    }
    
    /// Добавить обработчик при необходимости
    private func addTargetIfNeeded() {
        guard !self.isSubscribed else { return }
        self.addTarget(self, action: #selector(self.touchUpInside), for: .touchUpInside)
        self.isSubscribed = true
    }
    
}

extension UCBaseButton {
    
    /// Контент для кнопки
    public struct Content: Equatable {
        public var icon: UIImage?
        public var title: String?
        public var isEnabled: Bool
        public var callback: ActionHandler?
        
        /// Контент для кнопки
        /// - Parameters:
        ///   - icon: иконка
        ///   - title: тектс
        ///   - isEnabled: состояние enabled/disabled
        ///   - actionHandler: замыкание для обработки нажатия на кнопку
        public init(icon: UIImage? = nil,
                    title: String? = nil,
                    isEnabled: Bool = true,
                    actionHandler: ActionHandler? = nil) {
            self.icon = icon
            self.title = title
            self.isEnabled = isEnabled
            self.callback = actionHandler
        }
    }
}
