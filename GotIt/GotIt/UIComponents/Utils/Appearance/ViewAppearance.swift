//
//  ViewAppearance.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

extension UIView {
    /// Внешний вид для View
    public struct Appearance {
        let backgroundColor: UIColor
        let cornerRadius: CGFloat?
        let borderColor: UIColor?
        let borderWidth: CGFloat?
        let tintColor: UIColor?
        let clipsToBounds: Bool?
        let alpha: CGFloat?
        let shadowColor: UIColor?
        let shadowOffset: CGSize?
        let shadowOpacity: Float?
        let shadowRadius: CGFloat?
        
        /// Инициализатор
        /// - Parameters:
        ///   - backgroundColor: Цвет фона
        ///   - cornerRadius: Радиус
        ///   - borderColor: Цвет границ
        ///   - borderWidth: Ширина Границы
        ///   - tintColor: Основной цвет
        public init(backgroundColor: UIColor = .clear,
                    cornerRadius: CGFloat? = nil,
                    borderColor: UIColor? = nil,
                    borderWidth: CGFloat? = nil,
                    tintColor: UIColor? = nil,
                    clipsToBounds: Bool? = nil,
                    alpha: CGFloat? = nil,
                    shadowColor: UIColor? = nil,
                    shadowOffset: CGSize? = nil,
                    shadowOpacity: Float? = nil,
                    shadowRadius: CGFloat? = nil) {
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            self.borderColor = borderColor
            self.borderWidth = borderWidth
            self.tintColor = tintColor
            self.clipsToBounds = clipsToBounds
            self.alpha = alpha
            self.shadowColor = shadowColor
            self.shadowOffset = shadowOffset
            self.shadowOpacity = shadowOpacity
            self.shadowRadius = shadowRadius
        }
    }
    
    /// Применить внешний вид для View
    /// - Parameter appearance: UIView.Appearance
    public func apply(_ appearance: UIView.Appearance) {
        self.backgroundColor = appearance.backgroundColor
        self.layer.cornerRadius = appearance.cornerRadius ?? 0
        self.layer.borderColor = appearance.borderColor?.cgColor
        self.layer.borderWidth = appearance.borderWidth ?? 0
        if let tintColor = appearance.tintColor {
            self.tintColor = tintColor
            self.tintColorDidChange()
        }
        if let clipsToBounds = appearance.clipsToBounds {
            self.clipsToBounds = clipsToBounds
        }
        if let alpha = appearance.alpha {
            self.alpha = alpha
        }
        if let shadowColor = appearance.shadowColor {
            self.layer.shadowColor = shadowColor.cgColor
        }
        if let shadowOffset = appearance.shadowOffset {
            self.layer.shadowOffset = shadowOffset
        }
        if let shadowOpacity = appearance.shadowOpacity {
            self.layer.shadowOpacity = shadowOpacity
        }
        if let shadowRadius = appearance.shadowRadius {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    public struct CompressionAndHugging {
        public struct Priority {
            public let vertical: UILayoutPriority
            public let horizontal: UILayoutPriority

            public init(vertical: UILayoutPriority, horizontal: UILayoutPriority) {
                self.vertical = vertical
                self.horizontal = horizontal
            }
            public static var defaultLow: Self {
                .init(vertical: .defaultLow, horizontal: .defaultLow)
            }

            public static var defaultHigh: Self {
                .init(vertical: .defaultHigh, horizontal: .defaultHigh)
            }

            public static var required: Self {
                .init(vertical: .required, horizontal: .required)
            }
        }

        public let compressionResistance: Priority
        public let hugging: Priority

        public init(compressionResistance: Priority = .defaultHigh,
                    hugging: Priority = .defaultLow) {
            self.compressionResistance = compressionResistance
            self.hugging = hugging
        }
    }
    
    public func setCompressionAndHugging(_ params: CompressionAndHugging) {
        self.setContentCompressionResistancePriority(params.compressionResistance.vertical, for: .vertical)
        self.setContentCompressionResistancePriority(params.compressionResistance.horizontal, for: .horizontal)
        self.setContentHuggingPriority(params.hugging.vertical, for: .vertical)
        self.setContentHuggingPriority(params.hugging.horizontal, for: .horizontal)
    }
}

