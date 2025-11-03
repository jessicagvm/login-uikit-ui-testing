//
//  ViewController.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 21/10/2025.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    private lazy var titleLabel: UILabel = { // what are the best practice lazy var or let ??
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
        return textField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.accessibilityIdentifier = "continue"
        //button.setTitle("continue", for: .normal)
        //5 button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
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

private extension ViewController {
    @objc func didTapContinueButton() {
        // navigate to next viewController
        print("tapping")
    }
}

private extension ViewController {
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
         //   continueButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 20),
            continueButton.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -24),
            continueButton.heightAnchor.constraint(equalToConstant: 52),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
}

extension ViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
