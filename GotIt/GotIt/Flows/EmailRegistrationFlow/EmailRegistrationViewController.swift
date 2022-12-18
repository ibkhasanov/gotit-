//
//  EmailRegistrationViewController.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit
import Bond
import ReactiveKit

extension EmailRegistrationViewController {
    /// Appearance
    struct Appearance {
        let view: UIView.Appearance
        let message: UILabel.Appearance
        let agreements: UILabel.Appearance
        let confirmButton: UCButton.Appearance
        let field: InputText.Appearance
        
        init(view: UIView.Appearance = .init(backgroundColor: UIColor.Branding.Background.grey),
             message: UILabel.Appearance = .init(textColor: UIColor.Branding.Text.black,
                                                 font: UIFont.Branding.Body.b1,
                                                 numberOfLines: 0,
                                                 lineBreakMode: .byWordWrapping,
                                                 textAlignment: .center),
             agreements: UILabel.Appearance = .init(textColor: UIColor.Branding.Text.black,
                                                 font: UIFont.Branding.Component.comment,
                                                 numberOfLines: 0,
                                                 lineBreakMode: .byWordWrapping,
                                                 textAlignment: .center),
             confirmButton: UCButton.Appearance = .primary,
             field: InputText.Appearance = .init()) {
            self.view = view
            self.message = message
            self.agreements = agreements
            self.confirmButton = confirmButton
            self.field = field
        }
    }
    
    /// Отступы
    struct Layout {
        let insets: UIEdgeInsets
        let messageInsets: UIEdgeInsets
        let spacing: CGFloat
        let buttonHeight: CGFloat
        let imageSize: CGSize
        let imageInsets: UIEdgeInsets
        let agreementsInsets: UIEdgeInsets
        let fieldHeight: CGFloat
        let inputText: InputText.Layout
        let buttonInsets: UIEdgeInsets
        
        /// Инициализатор
        /// - Parameters:
        ///   - spacing: Отступы между кнопками
        ///   - buttonHeight: Высота кнопок
        init(insets: UIEdgeInsets = .init(top: 20, left: 16, bottom: 0, right: 16),
             spacing: CGFloat = 6,
             buttonHeight: CGFloat = 52,
             messageInsets: UIEdgeInsets = .init(top: 20, left: 16, bottom: 0, right: 16),
             imageSize: CGSize = CGSize(width: 100, height: 100),
             imageInsets: UIEdgeInsets = .init(top: 20, left: 16, bottom: 0, right: 16),
             agreementsInsets: UIEdgeInsets = .init(top: 20, left: 16, bottom: 0, right: 16),
             fieldHeight: CGFloat = 50,
             inputText: InputText.Layout = .init(),
             buttonInsets: UIEdgeInsets = .init(top: 60, left: 40, bottom: 0, right: 40)) {
            self.insets = insets
            self.spacing = spacing
            self.buttonHeight = buttonHeight
            self.messageInsets = messageInsets
            self.imageSize = imageSize
            self.imageInsets = imageInsets
            self.agreementsInsets = agreementsInsets
            self.fieldHeight = fieldHeight
            self.inputText = inputText
            self.buttonInsets = buttonInsets
        }
    }
    
    /// State
    enum State {
        /// Контент
        case content(data: Content)
        /// Подтвердить
        case confirmContent(data: UCButton.Content)
        /// Загрузка
        case loading(isActive: Bool)
        /// Ошибка
        case error(data: NetworkErrorType)
    }
    
    /// Content
    struct Content {
        let email: InputText.Content
        let password: InputText.Content
        let confirmPassword: InputText.Content
        
        init(email: InputText.Content,
             password: InputText.Content,
             confirmPassword: InputText.Content) {
            self.email = email
            self.password = password
            self.confirmPassword = confirmPassword
        }
    }
}


final class EmailRegistrationViewController: UIViewController {
    private var image: UIImageView!
    private var message: Label!
    private var stackView: UIStackView!
    private var emailTextField: InputText!
    private var passwordTextField: InputText!
    private var confirmPasswordTextField: InputText!
    private var agreements: Label!
    private var confirmButton: UCButton!
    
    /// Layout
    private var layout: EmailRegistrationViewController.Layout
    /// Appearance
    private var appearance: EmailRegistrationViewController.Appearance
    /// ViewModel
    private var viewModel: EmailRegistrationViewModelProtocol
    
    /// Инициализатор с параметрами
    /// - Parameters:
    ///   - layout: параметры верстки
    ///   - appearance: стили верстки
    ///   - viewModel: viewModel
    init(layout: EmailRegistrationViewController.Layout,
         appearance: EmailRegistrationViewController.Appearance,
         viewModel: EmailRegistrationViewModelProtocol) {
        self.layout = layout
        self.appearance = appearance
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LoadView
    override func loadView() {
        self.addAndSetupSubviews(self.layout)
    }
    
    /// Добавление компонент и верстка экрана
    private func addAndSetupSubviews(_ layout: Layout) {
        let view = UIScrollView()
        
        self.image = UIImageView()
        self.image.image = self.viewModel.image
        view.addSubviewForAutoLayout(view: self.image)
        self.image.pinToSuperview(edges: [.top],
                                       insets: layout.imageInsets,
                                       safeArea: true,
                                       priority: .required)
        self.image.pinCenterToSuperview(of: .horizontal)
        self.image.pin(size: layout.imageSize)
        self.image.accessibilityIdentifier = "EmailRegistrationViewController.Image"
        
        self.message = Label()
        self.message.text = self.viewModel.message
        view.addSubviewForAutoLayout(view: self.message)
        self.message.accessibilityIdentifier = "EmailRegistrationViewController.Message"
        self.message.pinToSuperview(edges: [.left, .right],
                                       insets: layout.messageInsets,
                                       safeArea: true,
                                       priority: .required)
        self.message.pinTop(toBottom: self.image,
                            spacing: layout.messageInsets.top)
        
        self.stackView = UIStackView()
        self.stackView.spacing = layout.spacing
        self.stackView.alignment = .fill
        self.stackView.distribution = .fill
        self.stackView.axis = .vertical
        view.addSubviewForAutoLayout(view: self.stackView)
        self.stackView.pinToSuperview(edges: [.left, .right],
                                       insets: layout.insets,
                                       safeArea: true,
                                       priority: .required)
        self.stackView.pinTop(toBottom: self.message,
                            spacing: layout.insets.top)
         
        self.emailTextField = InputText(layout: layout.inputText)
        self.emailTextField.accessibilityIdentifier = "RegistrationViewController.EmailTextField"
        self.stackView.addArrangedSubview(self.emailTextField)
        
        self.passwordTextField = InputText(layout: layout.inputText)
        self.passwordTextField.accessibilityIdentifier = "RegistrationViewController.PasswordTextField"
        self.stackView.addArrangedSubview(self.passwordTextField)
        
        self.confirmPasswordTextField = InputText(layout: layout.inputText)
        self.confirmPasswordTextField.accessibilityIdentifier = "RegistrationViewController.ConfirmPasswordTextField"
        self.stackView.addArrangedSubview(self.confirmPasswordTextField)
        
        self.agreements = Label()
        self.agreements.text = self.viewModel.agreements
        view.addSubviewForAutoLayout(view: self.agreements)
        self.agreements.accessibilityIdentifier = "EmailRegistrationViewController.Agreements"
        self.agreements.pinToSuperview(edges: [.left, .right],
                                       insets: layout.agreementsInsets,
                                       safeArea: true,
                                       priority: .required)
        self.agreements.pinTop(toBottom: self.stackView,
                            spacing: layout.agreementsInsets.top)
        
        self.confirmButton = UCButton()
        self.confirmButton.accessibilityIdentifier = "RegistrationViewController.ConfirmButton"
        view.addSubviewForAutoLayout(view: self.confirmButton)
        self.confirmButton.pin(height: layout.buttonHeight)
        self.confirmButton.pinToSuperview(edges: [.left, .right],
                                       insets: layout.buttonInsets,
                                       safeArea: true,
                                       priority: .required)
        self.confirmButton.pinTop(toBottom: self.agreements,
                            spacing: layout.buttonInsets.top)
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindSubviews()
        self.apply(appearance: self.appearance)
        self.viewModel.viewDidLoad()
    }
    
    /// Настройка байниднга
    private func bindSubviews() {
        self.viewModel.state.observeNext { [weak self] state in
            guard let _self = self else { return }
            switch state {
            case .content(let data):
                _self.setupContentView(data)
            case .confirmContent(let data):
                _self.confirmButton.content = data
            case .loading(let isActive):
                _self.loading(isActive)
            case .error(let data):
                _self.showError(data)
            }
        }.dispose(in: self.reactive.bag)
    }
    
    /// Настройка контената
    /// - Parameter content: Content
    private func setupContentView(_ content: Content) {
        self.emailTextField.content = content.email
        self.passwordTextField.content = content.password
        self.confirmPasswordTextField.content = content.confirmPassword
    }
    
    /// Показ прогресса
    /// - Parameter active: Bool
    private func loading(_ active: Bool) {
    }
    
    /// Показ ошибки
    /// - Parameter error: NetworkErrorType
    private func showError(_ error: NetworkErrorType) {
    }
    
    /// Применение настроек визуализации
    /// - Parameter appearance: настройки
    private func apply(appearance: Appearance) {
        self.view.apply(appearance.view)
        self.message.apply(appearance.message)
        self.agreements.apply(appearance.agreements)
        self.emailTextField.apply(appearance.field)
        self.passwordTextField.apply(appearance.field)
        self.confirmPasswordTextField.apply(appearance.field)
        self.confirmButton.apply(appearance: appearance.confirmButton)
    }
}
