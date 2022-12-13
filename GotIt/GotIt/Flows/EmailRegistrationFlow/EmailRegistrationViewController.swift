//
//  EmailRegistrationViewController.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

extension EmailRegistrationViewController {
    /// Appearance
    struct Appearance {
        let view: UIView.Appearance
        let message: UILabel.Appearance
        let agreements: UILabel.Appearance
        let confirmButton: UCButton.Appearance
        let titleField: UILabel.Appearance
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
             titleField: UILabel.Appearance = .init(textColor: UIColor.Branding.Text.black,
                                                    font: UIFont.Branding.Component.comment,
                                                    numberOfLines: 0,
                                                    lineBreakMode: .byWordWrapping,
                                                    textAlignment: .center),
             field: InputText.Appearance = .init()) {
            self.view = view
            self.message = message
            self.agreements = agreements
            self.confirmButton = confirmButton
            self.titleField = titleField
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
        let titleHeight: CGFloat
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
             titleHeight: CGFloat = 16,
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
            self.titleHeight = titleHeight
            self.fieldHeight = fieldHeight
            self.inputText = inputText
            self.buttonInsets = buttonInsets
        }
    }
    
    /// State
    enum State {
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
    private var emailLabel: Label!
    private var emailTextField: InputText!
    private var passwordLabel: Label!
    private var passwordTextField: InputText!
    private var confirmPasswordLabel: Label!
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
        
        self.emailLabel = Label()
        self.emailLabel.accessibilityIdentifier = "RegistrationViewController.EmailLabel"
        self.stackView.addArrangedSubview(self.emailLabel)
        self.emailLabel.pin(height: layout.titleHeight)
        
        self.emailTextField = InputText(layout: layout.inputText)
        self.emailTextField.accessibilityIdentifier = "RegistrationViewController.EmailTextField"
        self.stackView.addArrangedSubview(self.emailTextField)
        self.emailTextField.pin(height: layout.fieldHeight)
        
        self.passwordLabel = Label()
        self.passwordLabel.accessibilityIdentifier = "RegistrationViewController.PasswordLabel"
        self.stackView.addArrangedSubview(self.passwordLabel)
        self.passwordLabel.pin(height: layout.titleHeight)
        
        self.passwordTextField = InputText(layout: layout.inputText)
        self.passwordTextField.accessibilityIdentifier = "RegistrationViewController.PasswordTextField"
        self.stackView.addArrangedSubview(self.passwordTextField)
        self.passwordTextField.pin(height: layout.fieldHeight)
        
        self.confirmPasswordLabel = Label()
        self.confirmPasswordLabel.accessibilityIdentifier = "RegistrationViewController.ConfirmPasswordLabel"
        self.stackView.addArrangedSubview(self.confirmPasswordLabel)
        self.confirmPasswordLabel.pin(height: layout.titleHeight)
        
        self.confirmPasswordTextField = InputText(layout: layout.inputText)
        self.confirmPasswordTextField.accessibilityIdentifier = "RegistrationViewController.ConfirmPasswordTextField"
        self.stackView.addArrangedSubview(self.confirmPasswordTextField)
        self.confirmPasswordTextField.pin(height: layout.fieldHeight)
        
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
        self.apply(appearance: self.appearance)
        self.viewModel.viewDidLoad()
    }
    
    /// Применение настроек визуализации
    /// - Parameter appearance: настройки
    private func apply(appearance: Appearance) {
        self.view.apply(appearance.view)
        self.message.apply(appearance.message)
        self.agreements.apply(appearance.agreements)
        self.emailLabel.apply(appearance.titleField)
        self.passwordLabel.apply(appearance.titleField)
        self.confirmPasswordLabel.apply(appearance.titleField)
        self.emailTextField.apply(appearance.field)
        self.passwordTextField.apply(appearance.field)
        self.confirmPasswordTextField.apply(appearance.field)
        self.confirmButton.apply(appearance: appearance.confirmButton)
    }
}
