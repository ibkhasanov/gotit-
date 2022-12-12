//
//  UITextFieldAppearance.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import Foundation
import UIKit

extension UITextField {
    /// Внешний вид для UITextField
    public struct Appearance {
        let backgroundColor: UIColor
        let textColor: UIColor
        let textAlignment: NSTextAlignment?
        let font: UIFont
        let borderStyle: UITextField.BorderStyle?
        let clearButtonMode: ViewMode
        
        /// Инициализатор
        /// - Parameters:
        ///   - backgroundColor: Фон
        ///   - textColor: Цвет текста
        ///   - textAlignment: Направление
        ///   - font: Шрифт
        ///   - borderStyle: Стиль границ
        public init(backgroundColor: UIColor = .clear,
                    textColor: UIColor = .black,
                    textAlignment: NSTextAlignment? = nil,
                    font: UIFont = UIFont.systemFont(ofSize: 16),
                    borderStyle: UITextField.BorderStyle? = nil,
                    clearButtonMode: ViewMode = .whileEditing) {
            self.backgroundColor = backgroundColor
            self.textColor = textColor
            self.textAlignment = textAlignment
            self.font = font
            self.borderStyle = borderStyle
            self.clearButtonMode = clearButtonMode
        }
    }
    
    /// Применить внешний вид для UITextField
    /// - Parameter appearance: UITextField.Appearance
    public func apply(_ appearance: UITextField.Appearance) {
        self.backgroundColor = appearance.backgroundColor
        self.textColor = appearance.textColor
        self.font = appearance.font
        if let _textAlignment = appearance.textAlignment {
            self.textAlignment = _textAlignment
        }
        if let _borderStyle = appearance.borderStyle {
            self.borderStyle = _borderStyle
        }
        self.clearButtonMode = .never
        self.rightViewMode = appearance.clearButtonMode
    }
}
