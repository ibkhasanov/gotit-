//
//  InputText.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import Foundation
import UIKit

// MARK: Appearance, Layout
extension InputText {
    /// Внешний вид
    public struct Appearance {
        let title: UILabel.Appearance
        let text: UITextField.Appearance
        let comment: UILabel.Appearance
        let hSeparator: UIView.Appearance
        let hSeparatorActive: UIView.Appearance
        let errorColor: UIColor
        
        /// Инициализатор
        /// - Parameters:
        ///   - title: Внешний вид Заголовка
        ///   - text: Внешний вид поля
        ///   - comment: Внешний вид комментария
        ///   - hSeparator: Внешний вид разделителя
        ///   - hSeparatorActive: Внешний вид активного разделителя
        ///   - errorColor: Цвет ошибки
        public init(title: UILabel.Appearance = .init(textColor: UIColor.Branding.Text.darkGrey,
                                                      font: UIFont.Branding.Header.h7,
                                                      numberOfLines: 1,
                                                      lineBreakMode: .byWordWrapping),
                    text: UITextField.Appearance = .init(backgroundColor: UIColor.Branding.Background.default,
                                                         textColor: UIColor.Branding.Text.black,
                                                         textAlignment: NSTextAlignment.left,
                                                         font: UIFont.Branding.Body.b1,
                                                         borderStyle: UITextField.BorderStyle.roundedRect,
                                                         clearButtonMode: .whileEditing),
                    comment: UILabel.Appearance = .init(textColor: UIColor.Branding.Text.darkGrey,
                                                        font: UIFont.Branding.Component.comment,
                                                        numberOfLines: 0,
                                                        lineBreakMode: .byWordWrapping),
                    hSeparator: UIView.Appearance = .init(backgroundColor: UIColor.Branding.Background.clear),
                    hSeparatorActive: UIView.Appearance = .init(backgroundColor: UIColor.Branding.Background.clear),
                    errorColor: UIColor = UIColor.Branding.Text.red) {
            self.title = title
            self.text = text
            self.comment = comment
            self.hSeparator = hSeparator
            self.hSeparatorActive = hSeparatorActive
            self.errorColor = errorColor
        }
    }
    
    /// Отступы
    public struct Layout {
        let spacing: CGFloat
        let titleEdgeInsets: UIEdgeInsets
        let contentEdgeInsets: UIEdgeInsets
        let axis: NSLayoutConstraint.Axis
        let alignment: UIStackView.Alignment
        let distribution: UIStackView.Distribution
        let heightField: CGFloat
        let heightHSeparator: CGFloat
        let rectClearButton: CGRect
        
        /// Инициализатор отступов
        /// - Parameters:
        ///   - spacing: Отступы внутри UIStackView
        ///   - contentEdgeInsets: Отступы UIStackView
        ///   - axis: Направление Отступы внутри UIStackView
        ///   - alignment: Расположение UIStackView
        ///   - distribution: Наполнение UIStackView
        ///   - heightField: Высота поля
        ///   - heightHSeparator: Высота разделителя
        ///   - rectClearButton: CGRect кнопки очистить
        public init(spacing: CGFloat = 4,
                    titleEdgeInsets: UIEdgeInsets = .zero,
                    contentEdgeInsets: UIEdgeInsets = .zero,
                    axis: NSLayoutConstraint.Axis = NSLayoutConstraint.Axis.vertical,
                    alignment: UIStackView.Alignment = UIStackView.Alignment.fill,
                    distribution: UIStackView.Distribution = UIStackView.Distribution.fill,
                    heightField: CGFloat = 50,
                    heightHSeparator: CGFloat = 1,
                    rectClearButton: CGRect = CGRect(x: 0, y: 0, width: 24, height: 24)) {
            self.spacing = spacing
            self.titleEdgeInsets = titleEdgeInsets
            self.contentEdgeInsets = contentEdgeInsets
            self.axis = axis
            self.alignment = alignment
            self.distribution = distribution
            self.heightField = heightField
            self.heightHSeparator = heightHSeparator
            self.rectClearButton = rectClearButton
        }
    }
}

// MARK: InputText
final public class InputText: UIView {
    public var content: InputTextContentProtocol? {
        didSet {
            guard let _content = self.content else {
                return
            }
            /// Обновление заголовка
            if _content.title != oldValue?.title {
                self.title.text = _content.title
            }
            /// Обновление подсказки
            if _content.placeholder != oldValue?.placeholder {
                self.field.placeholder = _content.placeholder
            }
            /// Обновление значения поля
            if _content.value != oldValue?.value {
                /// Если есть регулярное выражение и оно не пустое
                if let regularExpression = self.content?.regularExpression, let value = _content.value?.block, !value.isEmpty {
                    if regularExpression.evaluate(with: value) {
                        self.field.text = value
                    }
                } else {
                    self.field.text = _content.value?.block
                }
            }
            /// Обновление заголовка
            if _content.comment != oldValue?.comment {
                self.comment.text = _content.comment
            }
            /// Обновление типа клавиатуры
            if oldValue?.keyboardType != _content.keyboardType, let type = _content.keyboardType {
                self.field.keyboardType = type
                self.field.inputView = nil
                self.field.inputAccessoryView = nil
            }
            /// Состояние ошибки
            if oldValue?.errorState != _content.errorState, let _appearance = self.appearance {
                self.apply(_appearance)
            }
            /// Обновление кнопки очистить
            if oldValue?.clearButton != _content.clearButton {
                self.setupClearButton(_content.clearButton)
            }
        }
    }
    
    /// Стэк вью
    private var stackView: UIStackView!
    /// Заголовок
    private var title: UILabel!
    /// Поле для ввода
    private var field: UITextField!
    /// Индикатор поля
    private var hSeparator: UIView!
    /// Заголовок
    private var comment: UILabel!
    
    /// Отступы компонента
    private var layout: InputText.Layout!
    /// Стили компонента
    private var appearance: InputText.Appearance?
    
    /// Дополнительный инициализатор с параметрами
    /// - Parameters:
    ///   - layout: отступы
    public init(layout: InputText.Layout) {
        self.layout = layout
        super.init(frame: .zero)
        self.addAndSetupSubviews(layout: layout)
    }
    
    /// Инициализатор, вызываемый при использовании компонента через Storyboard
    /// - Parameters:
    ///   - coder: NSCoder
    public required init?(coder: NSCoder) {
        self.layout = .init()
        super.init(coder: coder)
        self.addAndSetupSubviews(layout: self.layout)
    }

    
    /// Инициализация UI-элементов и настройка отступов
    /// - Parameter layout: отступы
    private func addAndSetupSubviews(layout: InputText.Layout) {
        /// Инициализация и настройка заголовка
        let title = UILabel()
        title.accessibilityIdentifier = "InputText.Title"
        self.addSubviewForAutoLayout(view: title)
        title.pinToSuperview(edges: [.top, .left, .right],
                             insets: layout.titleEdgeInsets)
        self.title = title
        
        /// Инициализация и настройка StackView
        let stackView = UIStackView()
        stackView.accessibilityIdentifier = "InputText.StackView"
        stackView.spacing = layout.spacing
        stackView.axis = layout.axis
        stackView.alignment = layout.alignment
        stackView.distribution = layout.distribution
        self.addSubviewForAutoLayout(view: stackView)
        stackView.pinToSuperview(edges: [.left, .right, .bottom],
                                 insets: layout.contentEdgeInsets)
        stackView.pinTop(toBottom: self.title, spacing: layout.titleEdgeInsets.bottom, priority: .required)
        self.stackView = stackView
        /// Инициализация и настройка поля
        let field = UITextField()
        field.accessibilityIdentifier = "InputText.Field"
        self.stackView.addArrangedSubview(field)
        self.field = field
        self.field.delegate = self
        self.field.pin(height: self.layout.heightField)
        /// Инициализация и настройка разделителя
        let hSeparator = UIView()
        hSeparator.accessibilityIdentifier = "InputText.HSeparator"
        self.stackView.addArrangedSubview(hSeparator)
        self.hSeparator = hSeparator
        self.hSeparator.pin(height: self.layout.heightHSeparator)
        /// Инициализация и настройка комментария
        let comment = UILabel()
        comment.accessibilityIdentifier = "InputText.Comment"
        self.stackView.addArrangedSubview(comment)
        self.comment = comment
    }

    /// Применение стилей к компоненту
    /// - Parameters:
    ///   - appearance: стили
    public func apply(_ appearance: InputText.Appearance) {
        self.appearance = appearance
        self.title.apply(appearance.title)
        self.field.apply(appearance.text)
        self.hSeparator.apply(appearance.hSeparator)
        self.comment.apply(appearance.comment)
        if let _errorState = self.content?.errorState, _errorState {
            self.title.textColor = appearance.errorColor
            self.field.textColor = appearance.errorColor
            self.hSeparator.backgroundColor = appearance.errorColor
            self.comment.textColor = appearance.errorColor
        }
    }
    
    /// Настройка кнопки очистить
    /// - Parameter image: Изображение
    private func setupClearButton(_ image: UIImage?) {
        if let _image = image {
            let clearButton = UIButton(frame: self.layout.rectClearButton)
            clearButton.accessibilityIdentifier = "InputText.ClearButton"
            clearButton.setImage(_image, for: .normal)
            clearButton.setImage(_image, for: .selected)
            clearButton.addTarget(self, action: #selector(self.cleanText), for: .touchUpInside)
            self.field.rightView = clearButton
        } else {
            self.field.rightView = nil
        }
    }
    
    /// Очитстить текст
    @objc private func cleanText() {
        self.content?.clearAction?()
        if let clean = self.content?.cleanValueWhenClearAction, clean {
            self.field.text = ""
            self.field.delegate = self
        }
    }
}

// MARK: UITextFieldDelegate
extension InputText: UITextFieldDelegate {
    /// Начали редактировать UITextField
    /// - Parameter textField: UITextField
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.content?.didBeginEditing?(textField.text)
        if let _errorState = self.content?.errorState, let _errorColor = self.appearance?.errorColor, _errorState {
            self.hSeparator.backgroundColor = _errorColor
        } else if let _hSeparatorActive = self.appearance?.hSeparatorActive {
            self.hSeparator.apply(_hSeparatorActive)
        }
    }
    
    /// Изменилось значение в поле
    /// - Parameters:
    ///   - textField: UITextField
    ///   - range: NSRange
    ///   - string: String
    /// - Returns: Bool
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /// Достпуность редактирования
        var enableEdit = self.content?.enabledEdit ?? true
        /// Поле не пустое
        if let text = textField.text {
            let updatedString = (text as NSString).replacingCharacters(in: range, with: string)
            /// Если есть регулярное выражение и редактирование доступно
            if let regularExpression = self.content?.regularExpression, !updatedString.isEmpty, enableEdit {
                enableEdit = regularExpression.evaluate(with: updatedString)
            }
            /// Если ввод разрешен, от отправляем данные
            if enableEdit {
                self.content?.changeValue?(updatedString)
            }
        }
        return enableEdit
    }
    
    /// Закончили редактировать UITextField
    /// - Parameter textField: UITextField
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.content?.didEndEditing?.block(textField.text)
        if let _errorState = self.content?.errorState, let _errorColor = self.appearance?.errorColor, _errorState {
            self.hSeparator.backgroundColor = _errorColor
        } else if let _hSeparator = self.appearance?.hSeparator {
            self.hSeparator.apply(_hSeparator)
        }
    }
}
