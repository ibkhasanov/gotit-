//
//  EmulateSplashViewController.swift
//  GotIt
//
//  Created by user on 12.12.2022.
//

import UIKit

extension RegistrationViewController {
    /// Appearance
    struct Appearance {
        let view: UIView.Appearance
        let emailButton: UCButton.Appearance
        let appleButton: UCButton.Appearance
        let googleButton: UCButton.Appearance
        let facebookButton: UCButton.Appearance
        let message: UILabel.Appearance
        let agreements: UILabel.Appearance
        
        init(view: UIView.Appearance = .init(backgroundColor: UIColor.Branding.Background.grey),
             emailButton: UCButton.Appearance = .primary,
             appleButton: UCButton.Appearance = .primary,
             googleButton: UCButton.Appearance = .primary,
             facebookButton: UCButton.Appearance = .primary,
             message: UILabel.Appearance = .init(textColor: UIColor.Branding.Text.black,
                                                 font: UIFont.Branding.Body.b1,
                                                 numberOfLines: 0,
                                                 lineBreakMode: .byWordWrapping,
                                                 textAlignment: .center),
             agreements: UILabel.Appearance = .init(textColor: UIColor.Branding.Text.black,
                                                 font: UIFont.Branding.Component.comment,
                                                 numberOfLines: 0,
                                                 lineBreakMode: .byWordWrapping,
                                                 textAlignment: .center)) {
            self.view = view
            self.emailButton = emailButton
            self.appleButton = appleButton
            self.googleButton = googleButton
            self.facebookButton = facebookButton
            self.message = message
            self.agreements = agreements
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
        
        /// Инициализатор
        /// - Parameters:
        ///   - spacing: Отступы между кнопками
        ///   - buttonHeight: Высота кнопок
        init(insets: UIEdgeInsets = .init(top: 20, left: 16, bottom: 0, right: 16),
             spacing: CGFloat = 12,
             buttonHeight: CGFloat = 42,
             messageInsets: UIEdgeInsets = .init(top: 30, left: 16, bottom: 0, right: 16),
             imageSize: CGSize = CGSize(width: 110, height: 110),
             imageInsets: UIEdgeInsets = .init(top: 20, left: 16, bottom: 0, right: 16),
             agreementsInsets: UIEdgeInsets = .init(top: 10, left: 16, bottom: 0, right: 16)) {
            self.insets = insets
            self.spacing = spacing
            self.buttonHeight = buttonHeight
            self.messageInsets = messageInsets
            self.imageSize = imageSize
            self.imageInsets = imageInsets
            self.agreementsInsets = agreementsInsets
        }
    }
    
    /// State
    enum State {
    }
    
    /// Content
    struct Content {
        let emailButton: UCButton.Content
        let appleButton: UCButton.Content
        let googleButton: UCButton.Content
        let facebookButton: UCButton.Content
        
        init(emailButton: UCButton.Content,
             appleButton: UCButton.Content,
             googleButton: UCButton.Content,
             facebookButton: UCButton.Content) {
            self.emailButton = emailButton
            self.appleButton = appleButton
            self.googleButton = googleButton
            self.facebookButton = facebookButton
        }
    }
}

final class RegistrationViewController: UIViewController {
    private var image: UIImageView!
    private var stackView: UIStackView!
    private var message: Label!
    private var emailButton: UCButton!
    private var appleButton: UCButton!
    private var googleButton: UCButton!
    private var facebookButton: UCButton!
    private var agreements: Label!
    
    /// Layout
    private var layout: RegistrationViewController.Layout
    /// Appearance
    private var appearance: RegistrationViewController.Appearance
    /// ViewModel
    private var viewModel: RegistrationViewModelProtocol
    
    /// Инициализатор с параметрами
    /// - Parameters:
    ///   - layout: параметры верстки
    ///   - appearance: стили верстки
    ///   - viewModel: viewModel
    init(layout: RegistrationViewController.Layout,
         appearance: RegistrationViewController.Appearance,
         viewModel: RegistrationViewModelProtocol) {
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
        let view = UIView()
        
        self.image = UIImageView()
        self.image.image = self.viewModel.image
        view.addSubviewForAutoLayout(view: self.image)
        self.image.pinToSuperview(edges: [.top],
                                       insets: layout.imageInsets,
                                       safeArea: true,
                                       priority: .required)
        self.image.pinCenterToSuperview(of: .horizontal)
        self.image.pin(size: layout.imageSize)
        self.image.accessibilityIdentifier = "RegistrationViewController.Image"
        
        self.message = Label()
        self.message.text = self.viewModel.message
        view.addSubviewForAutoLayout(view: self.message)
        self.message.accessibilityIdentifier = "RegistrationViewController.Message"
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
        
        self.emailButton = UCButton()
        self.emailButton.accessibilityIdentifier = "RegistrationViewController.EmailButton"
        self.stackView.addArrangedSubview(self.emailButton)
        self.emailButton.pin(height: layout.buttonHeight)
  
        self.appleButton = UCButton()
        self.appleButton.accessibilityIdentifier = "RegistrationViewController.AppleButton"
        self.stackView.addArrangedSubview(self.appleButton)
        self.appleButton.pin(height: layout.buttonHeight)

        self.googleButton = UCButton()
        self.googleButton.accessibilityIdentifier = "RegistrationViewController.PublicServiceButton"
        self.stackView.addArrangedSubview(self.googleButton)
        self.googleButton.pin(height: layout.buttonHeight)
        
        self.facebookButton = UCButton()
        self.facebookButton.accessibilityIdentifier = "RegistrationViewController.PublicServiceButton"
        self.stackView.addArrangedSubview(self.facebookButton)
        self.facebookButton.pin(height: layout.buttonHeight)
        
        self.agreements = Label()
        self.agreements.text = self.viewModel.agreements
        view.addSubviewForAutoLayout(view: self.agreements)
        self.agreements.accessibilityIdentifier = "RegistrationViewController.Agreements"
        self.agreements.pinToSuperview(edges: [.left, .right],
                                       insets: layout.agreementsInsets,
                                       safeArea: true,
                                       priority: .required)
        self.agreements.pinTop(toBottom: self.stackView,
                            spacing: layout.agreementsInsets.top)
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apply(appearance: self.appearance)
        self.viewModel.viewDidLoad { [weak self] content in
            guard let _self = self else { return }
            _self.emailButton.content = content.emailButton
            _self.appleButton.content = content.appleButton
            _self.googleButton.content = content.googleButton
            _self.facebookButton.content = content.facebookButton
        }
    }
    
    /// Применение настроек визуализации
    /// - Parameter appearance: настройки
    private func apply(appearance: Appearance) {
        self.view.apply(appearance.view)
        self.message.apply(appearance.message)
        self.emailButton.apply(appearance: appearance.emailButton)
        self.appleButton.apply(appearance: appearance.appleButton)
        self.googleButton.apply(appearance: appearance.googleButton)
        self.facebookButton.apply(appearance: appearance.facebookButton)
        self.agreements.apply(appearance.agreements)
    }
}
