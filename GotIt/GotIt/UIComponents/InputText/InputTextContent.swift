//
//  InputTextContent.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import Foundation
import UIKit

/// MARK: InputTextContentProtocol
/// Протокол для Content InputText
public protocol InputTextContentProtocol {
    /// Заголовок
    var title: String? { get }
    /// Подсказка
    var placeholder: String? { get }
    /// Значение в поле
    var value: CustomActionHandler<String?>? { get }
    /// Комментарий
    var comment: String? { get }
    /// Тип клавиатуры
    var keyboardType: UIKeyboardType? { get }
    /// Регулярное выражение
    var regularExpression: NSPredicate? { get }
    /// Доступность редактирования
    var enabledEdit: Bool { get }
    /// Ошибка
    var errorState: Bool { get }
    /// Ккнопка очистить
    var clearButton: UIImage? { get }
    /// Нажали очистить
    var clearAction: ActionHandler? { get }
    /// Очищение значения когда нажали на правое View
    var cleanValueWhenClearAction: Bool { get }
    /// Начали редактировать
    var didBeginEditing: ((_ value: String?) -> Void)? { get }
    /// Изменили значение
    var changeValue: ((_ value: String?) -> Void)? { get }
    /// Закончили редактировать
    var didEndEditing: CustomActionHandler<((String?) -> Void)>? { get }
}

extension InputText {
    /// Контент для компонента
    public struct Content: InputTextContentProtocol {
        public var title: String?
        public var placeholder: String?
        public var value: CustomActionHandler<String?>?
        public var comment: String?
        public var keyboardType: UIKeyboardType?
        public var regularExpression: NSPredicate?
        public var enabledEdit: Bool
        public var errorState: Bool
        public var clearButton: UIImage?
        public var clearAction: ActionHandler?
        public var cleanValueWhenClearAction: Bool
        public var didBeginEditing: ((_ value: String?) -> Void)?
        public var changeValue: ((_ value: String?) -> Void)?
        public var didEndEditing: CustomActionHandler<((String?) -> Void)>?
        
        /// Инициализатор
        /// - Parameters:
        ///   - title: Заголовок
        ///   - placeholder: Подсказка
        ///   - value: Значение в поле
        ///   - comment: Комментарий
        ///   - keyboardType: Тип клавиатуры
        ///   - errorState: Ошибка
        ///   - didBeginEditing: Начали редактировать
        ///   - changeValue: Изменили значение
        ///   - didEndEditing: Закончили редактировать
        ///   - clearButton: Ккнопка очистить
        ///   - accessibilityTurnOffMask: Доступность выключение маски
        ///   - regularExpression: Регулярное выражение
        ///   - clearAction: Действие очищения
        public init(title: String?,
                    placeholder: String?,
                    value: String?,
                    comment: String?,
                    keyboardType: UIKeyboardType?,
                    regularExpression: NSPredicate?,
                    enabledEdit: Bool,
                    errorState: Bool,
                    clearButton: UIImage?,
                    clearAction: ActionHandler?,
                    cleanValueWhenClearAction: Bool = true,
                    didBeginEditing: ((_ value: String?) -> Void)?,
                    changeValue: ((_ value: String?) -> Void)?,
                    didEndEditing: CustomActionHandler<((String?) -> Void)>?) {
            self.title = title
            self.placeholder = placeholder
            self.value = .init(value)
            self.comment = comment
            self.keyboardType = keyboardType
            self.regularExpression = regularExpression
            self.enabledEdit = enabledEdit
            self.errorState = errorState
            self.clearButton = clearButton
            self.clearAction = clearAction
            self.cleanValueWhenClearAction = cleanValueWhenClearAction
            self.didBeginEditing = didBeginEditing
            self.changeValue = changeValue
            self.didEndEditing = didEndEditing
        }
    
        /// Проверка является ли значение числом
        /// - Parameter value: Значение
        /// - Returns: Число
        private func isDigit(_ value: String) -> Bool {
            return Int(value) != nil
        }
    }
}
