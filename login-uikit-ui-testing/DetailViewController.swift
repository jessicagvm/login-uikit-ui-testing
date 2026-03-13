//
//  DetailViewController.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 27/02/2026.
//

import UIKit

class DetailViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = AccessibilityIdentifiers.DetailView.titleLabelId
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        configureView(with: "Selected Item")
    }
    
    func configureView(with title: String) {
        titleLabel.text = title
    }
    
    private func setUp() {
        self.view.backgroundColor = .black
        
        setUpHierarchy()
        setUpConstraints()
    }
    
    private func setUpHierarchy() {
        self.view.addSubview(self.titleLabel)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: (view.frame.width)-32),
            titleLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
