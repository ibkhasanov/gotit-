//
//  LabelAppearance.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import Foundation
import UIKit

extension UILabel {
    /// Применить Внешний вид
    /// - Parameter appearance: Внешний вид
    public func apply(_ appearance: Appearance) {
        self.numberOfLines = appearance.numberOfLines
        self.font = appearance.font
        self.textColor = appearance.textColor
        if let backgroundColor = appearance.backgroundColor {
            self.backgroundColor = backgroundColor
        }
        self.lineBreakMode = appearance.lineBreakMode
        self.textAlignment = appearance.textAlignment
        if let backgroundColor = appearance.backgroundColor {
            self.backgroundColor = backgroundColor
        }
    }
    
    /// Стиль UILabel
    public struct Appearance {
        let backgroundColor: UIColor?
        let font: UIFont
        let textColor: UIColor
        let numberOfLines: Int
        let lineBreakMode: NSLineBreakMode
        let textAlignment: NSTextAlignment

        /// Инициализатор
        /// - Parameters:
        ///   - backgroundColor: Цвет фона
        ///   - font: Шрифт
        ///   - textColor: Цвет текста
        ///   - numberOfLines: Количество линий
        ///   - lineBreakMode: Перенос
        public init(backgroundColor: UIColor? = nil,
                    textColor: UIColor,
                    font: UIFont,
                    numberOfLines: Int,
                    lineBreakMode: NSLineBreakMode,
                    textAlignment: NSTextAlignment = .left) {
            self.backgroundColor = backgroundColor
            self.font = font
            self.textColor = textColor
            self.numberOfLines = numberOfLines
            self.lineBreakMode = lineBreakMode
            self.textAlignment = textAlignment
        }
    }
    
    /// Сделать лейбл видимым на несколько секунд
    /// - Parameter time: Количество секунд для отображения
    public func highlightAsError(on time: Double) {
        self.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.isHidden = true
        }
    }
    
    /// Сделать лейбл видимым на несколько секунд
    /// - Parameter time: Количество секунд для отображения
    /// - Parameter completion: замыкание
    public func highlightAsError(on time: Double, completion: @escaping (() -> ())) {
        self.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.isHidden = true
            completion()
        }
    }
    
    /// Создать текст с Appearance
    /// - Parameter appearance: Appearance
    /// - Returns: UILabel
    public static func make(with appearance: UILabel.Appearance) -> UILabel {
        let label = UILabel()
        label.numberOfLines = appearance.numberOfLines
        label.font = appearance.font
        label.textColor = appearance.textColor
        if let background = appearance.backgroundColor {
            label.backgroundColor = background
        }
        label.lineBreakMode = appearance.lineBreakMode
        label.textAlignment = appearance.textAlignment
        return label
    }
}
