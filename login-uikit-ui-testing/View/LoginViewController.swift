//
//  LoginViewController.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 21/10/2025.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    private lazy var titleLabel: UILabel = { // TODO: - what are the best practice lazy var or let ??
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "username"
        textField.tintColor = .gray
        textField.keyboardType = .alphabet
        textField.font = .systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.textColor = .gray
        textField.backgroundColor = .black
        textField.textContentType = .username
        textField.layer.borderWidth = 1
        textField.layer.contents = 8
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.accessibilityIdentifier = AccessibilityIdentifiers.LoginView.usernameTextFieldId
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "password"
        textField.textColor = .gray
        textField.tintColor = .gray
        textField.font = .systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.keyboardType = .asciiCapable
        textField.textContentType = .password
        textField.backgroundColor = .black
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.contents = 8
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.accessibilityIdentifier = AccessibilityIdentifiers.LoginView.passwordextFielId
        return textField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = AccessibilityIdentifiers.LoginView.continueButtonId
        return button
    }()
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        //TODO: - delete later
        configureView(with: "")
    }
    
    func configureView(with model: String) {
        titleLabel.text = "Log in"
        continueButton.setTitle("continue", for: .normal)
    }
}

private extension LoginViewController {
    @objc func didTapContinueButton() {
        print("tapping")
        
        //        let items: Items = [Item(title: "item 1", image: UIImage()),
        //                            Item(title: "item 2", image: UIImage()),
        //                            Item(title: "item 3", image: UIImage()),
        //                            Item(title: "item 4", image: UIImage())]
        //        
        //        let vc = MainViewController()
        //        
        //        let serviceMock = MainServiceMock()
        //        serviceMock.result = .success(items)
        //        
        //        
        //        let presenter = MainViewPresenter(view: vc, service: serviceMock)
        //        
        //        vc.presenter = presenter
        
        let vc = AppCoordinator().showMainView()
        
        guard let navigationController = navigationController else {
            print("navigationController is nil")
            return
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
}

private extension LoginViewController {
    func setUp() {
        self.view.backgroundColor = .black
        continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        
        setUpHierarchy()
        setUpViewConstraints()
    }
    
    func setUpHierarchy() {
        view.addSubview(titleLabel)
        
        textFieldStackView.addArrangedSubview(usernameTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)
        
        view.addSubview(textFieldStackView)
        view.addSubview(continueButton)
    }
    
    func setUpViewConstraints() {
        setUpTitleLabelConstraints()
        setUpUsernameTextFieldConstraints()
        setUPasswordTextFieldConstraints()
        setUpTextFieldStackViewConstraints()
        setUpContinueButtonConstraints()
    }
    
    func setUpTitleLabelConstraints() {
        let view = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 38),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func setUpUsernameTextFieldConstraints() {
        usernameTextField.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    func setUPasswordTextFieldConstraints() {
        passwordTextField.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    func setUpTextFieldStackViewConstraints() {
        let view = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            textFieldStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            textFieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setUpContinueButtonConstraints() {
        let view = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -24),
            continueButton.heightAnchor.constraint(equalToConstant: 52),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
}

extension LoginViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// TODO: - move to another file
struct AccessibilityIdentifiers {
    struct LoginView {
        static let usernameTextFieldId: String = "loginView.usernameTextField.id"
        static let passwordextFielId: String = "loginView.passwordTextField.id"
        static let continueButtonId: String
        = "loginView.continueButton.id"
    }
    
    struct MainView {
        static let tableViewId: String = "mainView.tableView.id"
        static let cellId: String = "mainView.cellView.id"
    }
    
    struct DetailView {
        static let titleLabelId: String =
        "detailView.titleLabel.id"
    }
}
