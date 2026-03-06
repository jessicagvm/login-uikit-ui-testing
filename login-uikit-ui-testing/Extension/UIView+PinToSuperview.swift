//
//  UIView+PinToSuperview.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 11/02/2026.
//

import UIKit

extension UIView {
    func pinToSuperView(_ superView: UIView) {
        let view = superView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
