//
//  UCButton.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

extension UCButton {
    
    // MARK: Appearance
    public struct Appearance {
        let normal: StateAppearance
        let stateAppearances: [UIControl.State: StateAppearance]
        let cornerRadius: CGFloat
        let contentEdgeInsets: UIEdgeInsets
        
        /// Получение стиля по состоянию
        /// - Parameter state: состояние для UIControl
        /// - Returns: если стиль для состояния не найден, возвращаем стиль по умолчанию
        func stateAppearance(for state: UIControl.State) -> StateAppearance {
            self.stateAppearances[state] ?? self.normal
        }
        
        /// Стиль кнопки
        /// - Parameters:
        ///   - normalState: стиль кнопки по умолчанию
        ///   - otherStates: другие стили кнопки
        ///   - cornerRadius: закругление
        ///   - contentEdgeInsets: отступы кнопки для всего контента
        public init(normalState: StateAppearance,
                    otherStates: [UIControl.State: StateAppearance] = [:],
                    cornerRadius: CGFloat,
                    contentEdgeInsets: UIEdgeInsets = .zero) {
            self.normal = normalState
            self.stateAppearances = [.normal: normalState].merging(otherStates, uniquingKeysWith: { $1 })
            self.cornerRadius = cornerRadius
            self.contentEdgeInsets = contentEdgeInsets
        }
        
        public static var primary: Self {
            return .init(normalState: Self.normal,
                         otherStates: [UIControl.State.disabled : Self.disabled],
                         cornerRadius: 12)
        }
        
        /// Стиль описывающий состояние кнопки normal
        private static var normal: UCButton.StateAppearance {
            return .init(backgroundColor: UIColor.Branding.Button.white,
                         titleColor: UIColor.Branding.Text.black,
                         titleFont: UIFont.systemFont(ofSize: 16, weight: .semibold))
        }
        /// Стиль описывающий состояние кнопки disabled
        private static var disabled: UCButton.StateAppearance {
            return .init(backgroundColor: UIColor.Branding.Button.white,
                         titleColor: UIColor.Branding.Text.darkGrey,
                         titleFont: UIFont.systemFont(ofSize: 16, weight: .semibold))
        }
    }
    // MARK: StateAppearance
    public struct StateAppearance {
        let backgroundColor: UIColor
        let attributes: [NSAttributedString.Key: Any]
        
        ///  Стиль состояния
        /// - Parameters:
        ///   - backgroundColor: фон кнопки
        ///   - titleColor: цвет текста
        ///   - titleFont: шрифт текста
        ///   - attributes: атрибуты для кастомного текста
        public init(backgroundColor: UIColor,
                    titleColor: UIColor,
                    titleFont: UIFont,
                    attributes: [NSAttributedString.Key: Any] = [:]) {
            self.backgroundColor = backgroundColor
            var attributes = attributes
            attributes[.font] = titleFont
            attributes[.foregroundColor] = titleColor
            self.attributes = attributes
        }
    }
    
}




/// Базовый UI элемент button/Primary
public final class UCButton: UCBaseButton {
    private var appearance: Appearance?
    
    /// применение стиля к компоненту
    /// - Parameter appearance: стиль описывающий кастомизацию кнопки
    public func apply(appearance: Appearance) {
        self.appearance = appearance
        self.apply(state: .normal, appearance: appearance.stateAppearance(for: .normal))
        self.apply(state: .disabled, appearance: appearance.stateAppearance(for: .disabled))
        self.layer.cornerRadius = appearance.cornerRadius
        self.clipsToBounds = true
        self.contentEdgeInsets = appearance.contentEdgeInsets

        if let title = self.attributedTitle(for: self.state)?.string {
            let attributes = appearance.stateAppearance(for: self.state).attributes
            self.setAttributedTitle(NSAttributedString(string: title, attributes: attributes), for: self.state)
        }
        
        appearance.stateAppearances.forEach { [weak self] (state, appearance) in
            guard let _self = self else { return }
            _self.apply(state: state, appearance: appearance)
        }
    }
    
    /// Применение стиля к состоянию кнопки
    /// - Parameters:
    ///   - state: состояние UIControl
    ///   - appearance: задаваемый стиль
    private func apply(state: UIControl.State, appearance: StateAppearance) {
        let backgroundImageSize = CGSize(width: 1, height: 1)
        let backgroundImage = UIGraphicsImageRenderer(size: backgroundImageSize).image { context in
            appearance.backgroundColor.setFill()
            context.fill(CGRect(origin: .zero, size: backgroundImageSize))
        }
        self.setBackgroundImage(backgroundImage, for: state)
    }
    
    /// Установка текста кнопки с применением стилей
    /// - Parameters:
    ///   - title: текст
    ///   - state: состояние кнопки
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        let attributes = self.appearance?.stateAppearance(for: state).attributes
        let attributedText = title.map { NSAttributedString(string: $0, attributes: attributes) }
        self.setAttributedTitle(attributedText, for: state)
    }
}

