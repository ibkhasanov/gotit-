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
    }
    
    /// Layout
    struct Layout {
    }
    
    /// State
    enum State {
    }
    
    /// Content
    struct Content {
    }
}

final class EmailRegistrationViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
