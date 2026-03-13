//
//  MainViewController.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 26/01/2026.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    private lazy var table: MainTableViewController = {
        let viewController = MainTableViewController()
        viewController.tableView?.translatesAutoresizingMaskIntoConstraints = false
        viewController.accessibilityIdentifierBlock = {
            "movies_tableView"
        }
        viewController.tableView.accessibilityIdentifier =  AccessibilityIdentifiers.MainView.tableViewId
        return viewController
    }()
    
    // FIXME: - what is the best practice for this
    // unowned var presenter: MainViewPresenter! //*** Fatal error: Attempted to read an unowned reference but object 0x60000260a340 was already deallocated
    var presenter: MainViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setUp()
    }
}

private extension MainViewController {
    func setUp() {
        setUpMainTableView()
        setUpHierchacy()
        setUpConstraints()
    }
    
    func setUpMainTableView() { }
    
    func setUpHierchacy() {
        view.addSubview(table.tableView)
    }
    
    func setUpConstraints() {
        setUpTableConstraints()
    }
    
    func setUpTableConstraints() {
        guard let table = self.table.tableView else { return }
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MainViewController: MainTableViewProtocol {
    func didTapCell(with indexPath: IndexPath) {
        presenter.didTapCell(with: indexPath)
    }
    
    func didPullResquest() {
        presenter.didPullRefresh()
    }
}

extension MainViewController: MainViewProtocol {
    func showMovies(_ viewModel: [MovieViewModel]) {
        table.delegate = self
        table.configure(with: viewModel)
    }
    
    func showLoadingView(_ isLoading: Bool) {
        // call loading view
    }
    
    func showErrorView(message: String) {
        // call error view
    }
    
    func showEmptyStateView() {
        // call emptyView
    }
    
    func updateTable(with model: [MovieViewModel]) {
        // call update
    }
    
    func showDetailView(for item: MovieViewModel) {
        // call Detail View
        let vc = DetailViewController()
        
        guard let navigationController = navigationController else {
            print("navigationController is nil")
            return
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
}
