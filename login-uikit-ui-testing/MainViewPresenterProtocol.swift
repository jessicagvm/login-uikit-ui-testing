//
//  MainViewPresenterProtocol.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 11/02/2026.
//
import Foundation

protocol MainViewPresenterProtocol {
    func viewDidLoad()
    func didPullRefresh()
    func didTapCell(with indexPath: IndexPath)
}
